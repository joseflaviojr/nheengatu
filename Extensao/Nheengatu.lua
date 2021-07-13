--  ---------------------------------------------------------------------------
--  
--  Copyright (C) 2018-2021 José Flávio de Souza Dias Júnior
--  
--  This file is part of Nheengatu - <https://joseflavio.com/nheengatu/>.
--  
--  Nheengatu is free software: you can redistribute it and/or modify
--  it under the terms of the GNU Lesser General Public License as published by
--  the Free Software Foundation, either version 3 of the License, or
--  (at your option) any later version.
--  
--  Nheengatu is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
--  GNU Lesser General Public License for more details.
--  
--  You should have received a copy of the GNU Lesser General Public License
--  along with Nheengatu. If not, see <http://www.gnu.org/licenses/>.
--  
--  ---------------------------------------------------------------------------
--  
--  Direitos Autorais Reservados (C) 2018-2021 José Flávio de Souza Dias Júnior
--  
--  Este arquivo é parte de Nheengatu - <https://joseflavio.com/nheengatu/>.
--  
--  Nheengatu é software livre: você pode redistribuí-lo e/ou modificá-lo
--  sob os termos da Licença Pública Menos Geral GNU conforme publicada pela
--  Free Software Foundation, tanto a versão 3 da Licença, como
--  (a seu critério) qualquer versão posterior.
--  
--  Nheengatu é distribuído na expectativa de que seja útil,
--  porém, SEM NENHUMA GARANTIA; nem mesmo a garantia implícita de
--  COMERCIABILIDADE ou ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a
--  Licença Pública Menos Geral do GNU para mais detalhes.
--  
--  Você deve ter recebido uma cópia da Licença Pública Menos Geral do GNU
--  junto com Nheengatu. Se não, veja <http://www.gnu.org/licenses/>.
--  
--  ---------------------------------------------------------------------------

--- Variáveis definidas externamente, como em blocos de metadados.
local variaveis = {}

--- Mapeamento dos identificadores de capítulos.
-- chave = identificador no documento de origem (Markdown)
-- valor = identificador no documento final, normalmente uma numeração sequencial.
local capitulos = {}

--- Total de capítulos numerados.
local capitulos_total = 0

--- Variável temporária para auxiliar a numeração dos capítulos.
local capitulos_ultimo = { 0, 0, 0, 0, 0, 0 }

--- Mapeamento dos identificadores de figuras.
-- chave = identificador no documento de origem (Markdown)
-- valor = identificador no documento final, normalmente uma numeração sequencial.
local figuras = {}

--- Total de figuras numeradas.
local figuras_total = 0

--- Mapeamento dos identificadores de tabelas.
-- chave = identificador no documento de origem (Markdown)
-- valor = identificador no documento final, normalmente uma numeração sequencial.
local tabelas = {}

--- Total de tabelas numeradas.
local tabelas_total = 0

--- Mapeamento dos identificadores de códigos fontes.
-- chave = identificador no documento de origem (Markdown)
-- valor = identificador no documento final, normalmente uma numeração sequencial.
local codigos = {}

--- Total de códigos fontes numerados.
local codigos_total = 0

--- Mapeamento dos identificadores de equações matemáticas.
-- chave = identificador no documento de origem (Markdown)
-- valor = identificador no documento final, normalmente uma numeração sequencial.
local equacoes = {}

--- Total de equações matemáticas numeradas.
local equacoes_total = 0

--- Função que faz a manutenção de objetos Meta da AST da Pandoc.
--  Os valores dos metadados serão armazenados na tabela "variaveis".
--  O formato de identificação será "::" + chave + "::".
--  Exemplo: variaveis["::title::"] = "título do documento".
--  @param meta Objeto do tipo Meta.
function _Meta ( meta )
  for k, v in pairs(meta) do
    local chave = "::" .. k .. "::"
    variaveis[chave] = _Texto(v)
    if type(v) == "table" then
      if v.t == "MetaMap" then
        for sk, sv in pairs(v) do
          variaveis[ chave .. sk .. "::" ] = _Texto(sv)
        end
      end
    end
  end
end

--- Função que faz a manutenção de objetos Header da AST da Pandoc.
function _Header ( header )

  if _Contem(header.classes, "unnumbered") then
    return header
  end

  capitulos_total = capitulos_total + 1

  capitulos_ultimo[header.level] = capitulos_ultimo[header.level] + 1
  for i = header.level+1, 6 do
    capitulos_ultimo[i] = 0
  end

  local id = capitulos_ultimo[1]
  for i = 2, 6 do
    if capitulos_ultimo[i] == 0 then break end
    id = id .. "." .. tostring(capitulos_ultimo[i])
  end
  
  _SubstituirStr(header.content, "NN", id)

  local chave = header.attr[1]
  if chave then
    local nova = {}
    nova["id"] = id
    capitulos[chave] = nova
  end

  return header

end

--- Função que faz a manutenção de objetos Image da AST da Pandoc.
function _Image ( image )

  figuras_total = figuras_total + 1
  _SubstituirStr(image.caption, "NN", figuras_total)

  local chave = image.attr[1]
  if chave then
    local nova = {}
    nova["id"] = figuras_total
    figuras[chave] = nova
  end

  return image

end

--- Função que faz a manutenção de objetos Div da AST da Pandoc.
--  Dependendo do conteúdo da Div, ela terá um tratamento especial.
--  Casos especiais: tabelas, códigos fontes e equações matemáticas.
function _Div ( div )

  -- Tabela
  if div.content[1] and div.content[1].t == "Table" then

    table.insert(div.classes, "table-div")

    tabelas_total = tabelas_total + 1
    _SubstituirStr(div.content[1].caption, "NN", tabelas_total)

    local chave = div.attr[1]
    if chave then
      local nova = {}
      nova["id"] = tabelas_total
      tabelas[chave] = nova
    end

  -- Código Fonte
  elseif div.content[2] and div.content[2].t == "CodeBlock" then
    
    table.insert(div.classes, "sourceCode-div")

    codigos_total = codigos_total + 1
    _SubstituirStr(div.content[1], "NN", codigos_total)

    if FORMAT == "latex" then
      table.insert(div.content, 1, pandoc.RawBlock(FORMAT, "\\vspace{1em}\n{\\centering"))
      table.insert(div.content, 3, pandoc.RawBlock(FORMAT, "}"))
      table.insert(div.content, pandoc.RawBlock(FORMAT, "\\vspace{0.5em}"))
    end

    local chave = div.attr[1]
    if chave then
      local nova = {}
      nova["id"] = codigos_total
      codigos[chave] = nova
    end

  -- Equação Matemática
  elseif div.content[2] and div.content[2].content[1] and div.content[2].content[1].t == "Math" then

    local math = div.content[2].content[1]
    math.mathtype = "DisplayMath"

    table.insert(div.classes, "math-div")

    equacoes_total = equacoes_total + 1
    _SubstituirStr(div.content[1], "NN", equacoes_total)

    if FORMAT == "latex" then
      table.insert(div.content, 1, pandoc.RawBlock(FORMAT, "\\vspace{1em}\n{\\centering"))
      table.insert(div.content, 3, pandoc.RawBlock(FORMAT, "}"))
      table.insert(div.content, pandoc.RawBlock(FORMAT, "\\vspace{1em}\n"))
    elseif variaveis["::embutir-equacoes::"] == "true" then
      div.content[2].content[1] = _Equacao_Embutida(math, equacoes_total)
    end

    local chave = div.attr[1]
    if chave then
      local nova = {}
      nova["id"] = equacoes_total
      equacoes[chave] = nova
    end

  -- Destaque
  elseif _Contem(div.classes, "destaque") then
    if FORMAT == "latex" then
      table.insert(div.content, 1, pandoc.RawBlock(FORMAT, "\\vspace{1em}\n\\begin{mdframed}[hidealllines=true,backgroundcolor=blue!7,roundcorner=5pt]\n{\\parindent0pt\n"))
      table.insert(div.content, pandoc.RawBlock(FORMAT, "}\n\\end{mdframed}"))
    end

  -- Referências
  elseif div.attr[1] == "refs" then
    if FORMAT == "latex" then
      table.insert(div.content, 1, pandoc.RawBlock(FORMAT, "{\\parindent0pt"))
      table.insert(div.content, pandoc.RawBlock(FORMAT, "}"))
    end
  end

  return div

end

--- Função que faz a manutenção de objetos Math da AST da Pandoc.
function _Math ( math )
  if FORMAT ~= "latex" and variaveis["::embutir-equacoes::"] == "true" then
    return _Equacao_Embutida(math, 0)
  end
end

--- Função que faz a manutenção de objetos Link da AST da Pandoc.
--  A principal atividade deste método é substituir o padrão "NN" pelas numerações correspondentes.
--  Numerações compatíveis: capítulos, figuras, tabelas, códigos fontes e equações matemáticas.
function _Link ( link )
  if link.target:sub(1, 1) == "#" then
    local chave = link.target:sub(2)
    if capitulos[chave] then
      _SubstituirStr(link.content, "NN", capitulos[chave]["id"])
    elseif figuras[chave] then
      _SubstituirStr(link.content, "NN", figuras[chave]["id"])
    elseif tabelas[chave] then
      _SubstituirStr(link.content, "NN", tabelas[chave]["id"])
    elseif codigos[chave] then
      _SubstituirStr(link.content, "NN", codigos[chave]["id"])
    elseif equacoes[chave] then
      _SubstituirStr(link.content, "NN", equacoes[chave]["id"])
    end
  end
  return link
end

--- Função que faz a manutenção de objetos Str da Pandoc.
--  Principal atividade: reconhecer variáveis e substituí-las pelos seus valores.
function _Str ( str )
  
  if str.text:len() < 5 then return str end

  local p1, p2, p3, chave
  
  p1 = str.text:find("::", 1, true)
  if p1 == nil then return str end

  p2 = str.text:find("::", p1 + 2, true)
  if p2 == nil then return str end

  p3 = str.text:find("::", p2 + 2, true)

  if p3 then
    chave = str.text:sub(p1, p3 + 1)
  else
    chave = str.text:sub(p1, p2 + 1)
  end

  if variaveis[chave] then
    str.text = str.text:gsub(chave, variaveis[chave], 1)
  end

  return str

end

--- Função que faz a manutenção de objetos LineBlock da Pandoc.
function _LineBlock ( lineblock )
  if FORMAT == "latex" then
    table.insert(lineblock.content, 1, { pandoc.RawInline(FORMAT, "{\\parindent0pt\n") })
    table.insert(lineblock.content, { pandoc.RawInline(FORMAT, "}") })
    return lineblock
  end
end

--- Transformar em texto uma estrutura hierárquica de objetos.
function _Texto ( o )
  local tipo = type(o)
  if tipo == "string" then
    return o
  elseif tipo == "table" then
    return pandoc.utils.stringify(o)
  else
    return string.format("%s", o)
  end
end

--- Substitui na AST todas as ocorrências de um valor textual.
--  @param ast Objeto da AST da Pandoc.
--  @param alvo Valor textual a ser encontrado e substituído.
--  @param novo Valor textual que será utilizado na substituição.
function _SubstituirStr ( ast, alvo, novo )
  for k, v in pairs(ast) do
    if v.t == "Str" then
      if v.text:find(alvo) then
        v.text = v.text:gsub(alvo, novo)
      end
    else
      _SubstituirStr(v, alvo, novo)
    end
  end
end

--- Verifica a existência de um elemento dentro de um vetor.
--- @return true se existe no vetor um elemento idêntico ao informado.
function _Contem ( vetor, elemento )
	for i, v in ipairs(vetor) do
		if v == elemento then return true end
	end
	return false
end

--- Codifica uma string no formato URL.
--  Implementação original localizada em https://rosettacode.org/wiki/URL_encoding#Lua
function _URL_Codificar ( str )
  local saida, t = str:gsub("[^%w]", function (ch)
    return string.format("%%%X", string.byte(ch))
  end)
	return saida
end

--- Decodifica uma URL para string.
--  Implementação original localizada em https://rosettacode.org/wiki/URL_decoding#Lua
function _URL_Decodificar ( str )
  local saida, t = str:gsub("%%(%x%x)", function (hex)
    return string.char(tonumber(hex, 16))
  end)
	return saida
end

--- Converte uma equação matemática, em formato LaTeX, para uma imagem PNG.
--  Esta imagem é criada através do serviço on-line http://latex.codecogs.com/png.download.
--  Será feito o download da imagem, a qual será armazenada no subdiretório "Figura".
--  @param math Objeto do tipo Math.
--  @param numeracao Numeração especificada para a equação matemática.
--  @return Objeto Image que aponta para o endereço da imagem baixada.
function _Equacao_Embutida ( math, numeracao )
  local arquivo = "Figura/Equacao" .. string.format("%03d", numeracao) .. "_" .. math.text:gsub("[:/\\+?&= \t\n\r]", "_") .. ".png"
  os.execute("curl --silent -o " .. arquivo .. " http://latex.codecogs.com/png.download?" .. _URL_Codificar("\\large " .. math.text))
  local img = pandoc.Image("", arquivo)
  if math.mathtype == "DisplayMath" then
    img.classes = { "equacao-embutida-exibicao" }
  else
    img.classes = { "equacao-embutida-emlinha" }
  end
  return img
end

--- Verifica a compatibilidade do formato corrente com o formato HTML.
--  @see FORMAT
function _Compativel_HTML ()
  local prefixo = FORMAT:sub(1, 4)
  if prefixo == "html" or prefixo == "epub" then
    return true
  else
    return false
  end
end

--- Ordem analítica da AST da Pandoc, conforme as necessidades do Nheengatu.
return {{Meta = _Meta}, {Header = _Header}, {Image = _Image}, {Div = _Div}, {Math = _Math}, {Link = _Link}, {Str = _Str}, {LineBlock = _LineBlock}}
