---
# Este documento está no formato Nheengatu - <https://joseflavio.com/nheengatu/>
nheengatu: '1.0-A4' # Versão da Nheengatu
lang: 'pt-BR' # Idioma no formato https://tools.ietf.org/html/bcp47

title: 'Publicação de trabalhos com Pandoc e Nheengatu'
description: 'Exemplo de documento Pandoc utilizando Nheengatu.'
keywords:
- Markdown
- Pandoc
- Nheengatu

author:
- 'José Flávio de Souza Dias Júnior'
- 'Amanda Jéssica Frazão da Silva Dias'
# - { name : 'José Flávio de Souza Dias Júnior',
#     photo: 'Figura/Pessoa.png',
#     web  : 'https://joseflavio.com',
#     email: 'email@joseflavio.com' }

rights: '© 2020 José Flávio de Souza Dias Júnior'
publisher: 'Publicação independente'
date: '2020-08-19' # Data da publicação, no formato https://www.w3.org/TR/NOTE-datetime
date-long: '19 de agosto de 2020'

localidade: 'Tucuruí, Pará, Brasil'
instituicao-nivel1: 'Instituição Nível Hierárquico 1'
instituicao-nivel2: 'Instituição Nível Hierárquico 2'
instituicao-nivel3: 'Instituição Nível Hierárquico 3'

toc-title: 'Sumário'
toc: true
lof-title: 'Lista de figuras'
lof: true
lot-title: 'Lista de tabelas'
lot: true
loa-title: 'Lista de abreviaturas e siglas'
loa: true
los-title: 'Lista de símbolos'
los: true

icone: 'Figura/Icone.ico' # Ícone que representa o documento
marca: 'Figura/Marca.png' # Marca que representa o conteúdo ou o proprietário deste trabalho
marca-tamanho: 0.2 # Tamanho padrão da marca (%)
cover-image: 'Figura/Capa.jpg' # Capa para livro eletrônico

bibliography: 'Bibliografia.bibtex' # Banco de dados bibliográfico
csl: 'Estilo/ABNT.csl' # Estilo de formatação das citações e da bibliografia
link-citations: true # Criar link da citação para a bibliografia correspondente?

embutir-equacoes: false # Embutir equações matemáticas como imagens sempre que possível?

papersize: 'A4'
geometry: 'margin=2cm'

# Objeto para fins de testes
teste: { texto: 'Objeto de Teste', numero: 2.1 }

# Abreviaturas e siglas
siglas:
- { sigla: 'EPUB', descricao: 'Electronic Publication' }
- { sigla: 'HTML', descricao: 'Hyper Text Markup Language' }
- { sigla: 'PDF',  descricao: 'Portable Document Format' }

# Símbolos
simbolos:
- { simbolo: '$\Delta$', descricao: 'Delta' }

preambulo: 'Projeto apresentado à comunidade de software livre a fim de contribuir de forma significativa na construção de técnicas de publicação de trabalhos.'
abstract: ''
---

# Introdução {#introducao}

Este trabalho foi elaborado para demonstrar como é fácil escrever e formatar artigos, livros eletrônicos, páginas Web e similares através da [Pandoc][^nota-pandoc] em conjunto com a sua extensão [Nheengatu][^nota-nheengatu].

[Pandoc] é uma adaptação da linguagem [Markdown][^nota-md], originalmente criada para possibilitar a criação de páginas [HTML] sem o uso intensivo de *tags* de marcação. A [Pandoc] integra também um conjunto de ferramentas para conversão entre diversos formatos de documentos.

:::::: {.destaque}
A Nheengatu é software livre e todo o seu código fonte está disponível no repositório público **Github**: <https://github.com/joseflaviojr/nheengatu>
::::::

[Nheengatu] é uma extensão da [Pandoc], escrita na linguagem [Lua], que implementa diversos recursos indisponíveis ou deficientes na versão nativa da [Pandoc], como a numeração e referenciação personalizável de capítulos, figuras, tabelas, equações matemáticas e códigos fontes. A [Nheengatu] também tem o objetivo de padronizar a organização dos arquivos que compõem um trabalho completo de edição textual, facilitando a compreensão da estrutura e possibilitando a criação de *scripts* externos que complementem o comportamento natural da [Pandoc].

Com base nisso, este trabalho visa demonstrar de forma prática os principais recursos da combinação [Pandoc] e [Nheengatu]. Aconselha-se comparar o conteúdo original deste documento, escrito ao estilo [Markdown], com os diversos produtos resultantes do processo de conversão, tais como [LaTeX], [PDF], [HTML] e [EPUB], a fim de aprender por similaridade para redigir neste formato suas próprias publicações.

Está disponível para fins de comparação alguns formatos deste mesmo trabalho:

* Original em **Markdown/Pandoc + Nheengatu**: <https://raw.githubusercontent.com/joseflaviojr/nheengatu/master/Trabalho.md>

* Convertido para formato de impressão **PDF**:
  * <https://joseflavio.com/nheengatu/Trabalho-Projeto.pdf>
  * <https://joseflavio.com/nheengatu/Trabalho.pdf>

* Convertido para página Web **HTML**: <https://joseflavio.com/nheengatu>

* Convertido para livro eletrônico **EPUB**: <https://joseflavio.com/nheengatu/Trabalho.epub>

[^nota-pandoc]: <https://pandoc.org/MANUAL.html#pandocs-markdown>
[^nota-nheengatu]: <https://joseflavio.com/nheengatu/>
[^nota-md]: <https://daringfireball.net/projects/markdown/>

# Como utilizar a Nheengatu

Criar com [Nheengatu] um trabalho para publicação é bem simples:

1. Baixe o modelo de projeto em <https://github.com/joseflaviojr/nheengatu/archive/1.0-A4.zip>, o qual atualmente está na versão `1.0-A4`.

1. Descompacte `1.0-A4.zip` e renomeie o diretório resultante `nheengatu-1.0-A4`, o qual contém todos os arquivos que compõem um trabalho [Nheengatu].

1. Edite o arquivo `Trabalho.md` redigindo o conteúdo que deseja publicar.

1. Execute o comando `./Gerar.sh html`{.sh} para gerar uma página [HTML] com conteúdo correspondente ao `Trabalho.md`. De fato, a [Nheengatu] processará todos os arquivos `*.md` presentes no diretório do projeto, considerando cada um como um trabalho independente.

1. Outras opções de conversão:
    * `./Gerar.sh latex`{.sh}
    * `./Gerar.sh epub`{.sh}
    * `./Gerar.sh <nome de algum modelo disponível>`{.sh}

## Requisitos

Para o pleno funcionamento do processo de conversão de documentos é necessária a instalação das seguintes ferramentas:

* [Pandoc - universal document converter](https://pandoc.org/installing.html): sistema base para a conversão de documentos - <https://pandoc.org/installing.html>.

* [pandoc-citeproc](https://github.com/jgm/pandoc-citeproc/blob/master/man/pandoc-citeproc.1.md): extensão da Pandoc que otimiza a técnica de citação de trabalhos de terceiros - <https://github.com/jgm/pandoc-citeproc/blob/master/man/pandoc-citeproc.1.md>.

* [curl](https://curl.haxx.se/): ferramenta para download de arquivos da Internet, necessária caso deseje embutir equações matemáticas na forma de imagens - <https://curl.haxx.se/>.

# Capítulo e parágrafo

A maioria das publicações é composta basicamente por capítulos e parágrafos, e na [Pandoc] a definição deles é feita na forma tradicional da [Markdown].

Capítulos e subcapítulos são normalmente definidos através de linhas de texto prefixadas com o caractere `#`, sendo que a quantidade destes caracteres especificam em que nível está o capítulo. Acesse <https://pandoc.org/MANUAL.html#headings> para mais detalhes.

Os parágrafos são definidos através de linhas textuais normais, exigindo-se apenas que os parágrafos sejam separados por linhas em branco, como especificado em <https://pandoc.org/MANUAL.html#paragraphs>.

Pode-se forçar a quebra de linha de um parágrafo \
dessa forma.

## Subcapítulo ou subseção

Isto é um exemplo de parágrafo dentro de um subcapítulo.

## Capítulo/subcapítulo sem numeração {-}

A [Pandoc] fornece um mecanismo simples de indicar a não numeração de um capítulo ou subcapítulo.

# Recursos básicos

Exemplo de **texto negrito**, *texto itálico* e ~~texto cortado~~.

Sobrescrito e subscrito: H~2~O é um líquido e 2^10^ é igual a 1024.

*Link* implícito para o site do [Google](https://www.google.com/).

*Link* explícito para o site do <https://www.google.com/>.

*Link* para alguma seção deste documento: [voltar para o capítulo de introdução](#introducao).

Outras formas de se fazer *links* estão descritas em <https://pandoc.org/MANUAL.html#links>.

Linha horizontal para indicar mudança de temática:

------

--- Travessão.

-- Traço.

# Figura

A [Figura NN](#FigCapa) exemplifica inserção, numeração, rotulação, dimensionamento e referência de figuras em documentos [Nheengatu].

O local padrão de armazenamento de arquivos de imagens é no subdiretório `Figura` do projeto de publicação.

![**Figura NN.** Capa deste trabalho no formato de livro eletrônico.](Figura/Capa.jpg){#FigCapa width=30%}

# Diagrama

Uma das melhores formas de representar e explorar pensamentos, ideias e conhecimentos é através de diagramas, por isso, recomenda-se utilizar diagramas em todas as fases de um trabalho, principalmente no início, mesmo quando o contexto e o escopo ainda não tenham sido claramente definidos.

Um diagrama consiste, de fato, em uma [Figura](#figura), contudo, como alternativa rápida de composição, a [Nheengatu] possibilita a construção de diagramas através de uma linguagem textual, disponível através da ferramenta [mermaid](https://mermaid-js.github.io/mermaid/#/flowchart?id=graph), já embutida na Nheengatu no âmbito da HTML. Demonstra-se, a seguir, um exemplo abrangente de fluxograma.

:::::: {.destaque}
Diagramas [mermaid](https://mermaid-js.github.io/mermaid/#/flowchart?id=graph) estão disponíveis apenas para HTML.
::::::

<pre class="mermaid">

graph TB
    
    %% Comentário
    inicio[Início]:::aten --> meio
    fim([Fim far:fa-check-circle .]):::aten
    
    subgraph subg1 [Subgrafo 1]
        meio(Meio):::aten --> duvida{Dúvida}
        meio -.- nota>Manual da linguagem]:::norm
        click nota "https://mermaid-js.github.io/mermaid/#/flowchart?id=graph" "Manual da linguagem de diagrama mermaid."
    end

    subgraph subg2 [Subgrafo 2]
        a[AAA] -.-|armazena em| b[(BBB)]
        a ==> c((CCC))
        recurso[/Recurso/] -.-> c
        c --- d(DDD)
    end

    %% Inter-relações
    duvida -->|Sim| a
    duvida -->|Não| fim
    c --> fim

    %% Estilo
    classDef default fill:#d6eaf8,stroke:#0074d9,color:#111111,stroke-width:1px;
    classDef norm    fill:#d6eaf8,stroke:#0074d9,color:#111111,stroke-width:1px;
    classDef aten    fill:#fadbd8,stroke:#ff4136,color:#111111,stroke-width:1px;

</pre>

Orientações de fluxo mais comuns para fluxogramas mermaid: **TB** (top to bottom) ou **LR** (left to right).

# Tabela

Estruturas de tabela orientam a leitura, economizam espaço textual e otimizam a interpretação e a correlação dos dados, como se pode observar na [Tabela NN](#Tab001), a qual foi formatada através de uma das técnicas especificadas em <https://pandoc.org/MANUAL.html#tables> e melhorada pela [Nheengatu] em relação à numeração e ao referenciamento. Neste exemplo,  demonstra-se também que o posicionamento dos rótulos das colunas especifica o seu alinhamento desejado: à direita, à esquerda, central e padrão.

:::::: {#Tab001}
Table: **Tabela NN.** Exemplo de tabela de dados com alinhamento de colunas.

  Direita  Esquerda      Centro    Padrão
---------  ----------  ----------  ------
12         12          12          12
123        123         123         123
1          1           1           1

::::::

:::::: {.destaque}
A ferramenta <http://www.tablesgenerator.com/markdown_tables> fornece uma interface gráfica para criação de tabelas.
::::::

# Equação matemática

Equações matemáticas podem ser expressas em linha, como neste caso $\Delta = b^2-4ac$, ou no modo de exibição para ganhar destaque e numeração, como no caso da [Equação NN](#Eq001).

:::::: {#Eq001}
**Equação NN.** Equação do segundo grau.

$x = \frac{-b \pm \sqrt{\Delta}}{2a}$

::::::

Nos casos de publicações que precisam depender minimamente da Internet, a qual normalmente é necessária para construir e demonstrar fórmulas, as equações matemáticas podem ser embutidas na forma de imagens, bastando para isso habilitar a variável `embutir-equacoes: true` no cabeçalho do documento.

:::::: {.destaque}
Definir equações matemáticas realmente é um processo um pouco mais complicado, porém existem serviços *online* que auxiliam no desenho dessas fórmulas, como o editor visual <http://latex.codecogs.com/eqneditor/editor.php>.
::::::

# Código fonte

O [Código Fonte NN](#Cod001) demonstra a principal forma de incluir instruções de programação em documentos [Pandoc] que utilizam [Nheengatu]. Acesse <https://pandoc.org/MANUAL.html#verbatim-code-blocks> para mais detalhes.

:::::: {#Cod001}
**Código Fonte NN.** Exemplo de código fonte de aplicação em linguagem Java.

~~~~~~ {.java .numberLines startFrom="1"}
public class AloMundo {
    public static void main( String[] args ) {
        System.out.println( "Alô, Mundo!" );
    }
}
~~~~~~

::::::

Códigos fontes podem também ser expressos `var x = 21;`{.javascript} dentro de parágrafos.

A indicação da `linguagem de programação` não é exigida em todos os casos.

# Citação

Citações de trabalhos de terceiros requerem bancos de dados bibliográficos, como o popular [BibTeX](http://www.bibtex.org/), padrão utilizado pelo [LaTeX], o qual é representado neste projeto pelo arquivo `Bibliografia.bibtex`. A montagem manual deste tipo de arquivo pode ser feita através de serviços *online* como o <http://truben.no/latex/bibtex/>, contudo, normalmente se buscam versões já prontas em repositórios de citações, como o <https://www.mendeley.com/search/?query=>.

Após a completa especificação do banco de dados bibliográfico, basta realizar citações como: Segundo @Biblia, Jesus escolheu 12 discípulos...

Pode-se também fazer citação em relação a um bloco de texto: "Ide por todo o mundo e pregai o Evangelho a toda criatura" [@Biblia].

É possível fazer múltiplas citações para um mesmo bloco de texto: "Jesus é o caminho, a verdade e a vida" [@Biblia; @Igreja].

A formatação das citações e da bibliografia é feita com base na *Citation Style Language*[^nota-csl] ([CSL]). A [Nheengatu] utiliza por padrão o estilo definido no arquivo `Estilo/ABNT.csl`, especificado de forma similar à norma brasileira NBR 10520 [@NBR10520]. Outros arquivos de estilo de citação podem ser obtidos no repositório <https://www.zotero.org/styles> ou personalizados através do editor visual <http://editor.citationstyles.org/visualEditor/>.

Mais detalhes técnicos sobre como fazer citações na [Pandoc] podem ser obtidos no endereço <https://pandoc.org/MANUAL.html#citations>.

[^nota-csl]: <https://citationstyles.org/>

# Lista

Existem várias formas de definir listas, como demonstradas em <https://pandoc.org/MANUAL.html#lists>.

Lista compacta:

* um
* dois
* três

Lista solta, na qual se mantém um espaço livre entre os itens:

* um

* dois

* três

Listas podem conter sublistas, sendo que para isso basta alinhar o submarcador com o primeiro caractere do texto da lista superior:

* cores
  + vermelho
  + verde
  + azul
    - celeste
    - marinho
* formas
  + quadrado
  + círculo

Lista numerada automaticamente:

1. um
1. dois
1. três

Lista numerada automaticamente a partir de um número específico:

9) nove
1) dez
1) onze
1) doze

Lista com numeração romana:

i. um
ii. dois
iii. três

# Bloco de citação

Blocos de citação são utilizados para expor trechos de textos extraídos de outras obras.

> Feliz o homem que não procede conforme o conselho dos ímpios, não trilha o caminho dos pecadores, nem se assenta entre os escarnecedores. Feliz aquele que se compraz no serviço do Senhor e medita sua lei dia e noite.
>
> Salmos 1,1-2 [@Biblia]

# Bloco livre

Bloco livre é um pequeno texto no qual se preserva os deslocamentos e as quebras de linha. Útil para poemas e endereços:

| "Feliz o homem que não procede conforme
| o conselho dos ímpios,
| não trilha o caminho dos pecadores,
| nem se assenta entre os escarnecedores.
| 
| Feliz aquele que se compraz no
| serviço do Senhor e
| medita sua lei dia e noite."
| 
|             Salmos 1,1-2 [@Biblia]

# Destaque

Destaque é uma região que é apresentada de tal forma a realçar o seu conteúdo em relação aos elementos adjacentes.

:::::: {.destaque}
Exemplo de texto em destaque.

Segundo parágrafo.
::::::

# Nota de rodapé

As notas de rodapé[^1] são úteis para anexar informações complementares.[^nota]

[^1]: Mais informações acerca de notas de rodapé em <https://pandoc.org/MANUAL.html#footnotes>.

[^nota]: Exemplo de nota de rodapé com múltiplas linhas.
    
    Parágrafo 2, Linha 1\
    Parágrafo 2, Linha 2\
    Parágrafo 2, Linha 3
    
    Parágrafo 3

# Variável

A [Nheengatu] disponibiliza um meio de capturar o valor atribuído a uma variável ou atributo de objeto definido no cabeçalho do documento.

O título deste trabalho é "::title::" e será impresso no tamanho **::papersize::**.

O objeto de teste tem como valor de texto = "::teste::texto::" e número = ::teste::numero::!

# Referências {-}

:::::: {#refs}
::::::

Exemplo de parágrafo logo depois das referências.

[CSL]: https://citationstyles.org/
[EPUB]: https://pt.wikipedia.org/wiki/EPUB
[HTML]: https://www.w3schools.com/html/html_intro.asp
[LaTeX]: https://pt.wikipedia.org/wiki/LaTeX
[Lua]: https://www.lua.org/about.html
[Pandoc]: https://pandoc.org/MANUAL.html#pandocs-markdown
[PDF]: https://pt.wikipedia.org/wiki/Portable_Document_Format
[Markdown]: https://daringfireball.net/projects/markdown/
[Nheengatu]: https://joseflavio.com/nheengatu/
