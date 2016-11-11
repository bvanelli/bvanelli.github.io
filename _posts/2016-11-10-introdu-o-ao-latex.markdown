---
published: true
title: Introdução ao LaTeX
layout: post
---

<!-- Include MathJax to render LaTeX. This might not work -->
<script type="text/x-mathjax-config">
  MathJax.Hub.Config({
      jax: ["input/TeX","output/SVG"],
      inlineMath: [['\(','\)']]
   });
  </script>
  <script type="text/javascript"
          src="https://cdn.mathjax.org/mathjax/latest/MathJax.js">
</script>


> Esse é um documento de introdução ao LaTeX. Para ver um exemplo de documento [clique aqui](https://github.com/bvanelli/texdefault/raw/master/build/standard_output.pdf).

----------

- [Instalando o LaTeX](#)
	- [Windows](#)
	- [Linux](#)
- [Primeiro Documento](#)
- [Escrevendo Equações](#)
- [Títulos, Subtítulos e Referências Cruzadas](#)
- [Sumário](#)
- [Inserindo Imagens](#)
	- [Imagens Simples](#)
	- [Imagens Lado a Lado](#)
	- [Organizando uma pasta de imagens](#)
- [Formatação](#)
- [Tabelas](#)
- [Exemplo](#)

---------

O LaTeX (pronunciado "*Lah-tek*'') é uma ferramenta de preparação de textos de alta qualidade usado normalmente na publicação de trabalhos técnicos e científicos. O objetivo do LaTeX não é ser uma ferramenta de processamento de textos gráfica, mas sim uma linguagem onde o usuário se foca apenas em escrever, e deixa o programa lidar com os estilos dos títulos, subtítulos, referências, etc.

> **Pontos Positivos:**
>
> - Altamente Customizável.
> - Produz documentos de alta qualidade.
> - Melhor controle sobre grandes documentos, como bibliografia, citação de imagens e equações, etc.
> - Amplo suporte para equações e formulação matemática.
> - Boa documentação em fóruns como [StackExchange](http://tex.stackexchange.com/).
>
> **Pontos Negativos:**
>
> - Curva íngreme de aprendizado nos estágios iniciais.
> - Códigos de estilo são mais complicados.
> - A digitação tende a ser mais intuitiva do que visual.

## Instalando o LaTeX

### Windows
O requisito mínimo para se rodar LaTeX é um compilador, que converterá o código em um documento PDF ou DVI. No **Windows**, utiliza-se o [MiKTeX](https://miktex.org/download). Para um pequeno tutorial de como instalar o MiKTeX e um editor de texto clique [aqui](https://github.com/bvanelli/texdefault/blob/master/README.md).

### Linux
Se seu sistema operacional for **Linux**, você vai precisar dos pacotes `texlive`. A melhor opção é instalar diretamente o pacote `texlive-full` que irá instalar diretamente todos os pacotes disponíveis  ([lista de pacotes para o Ubuntu](http://packages.ubuntu.com/trusty/texlive-full)). Para Debian e derivados, basta rodar o comando `apt-get install texlive-full`.

## Primeiro Documento

Um documento básico em LaTeX vai parecer algo do tipo:

```Latex
% Início do documento
\documentclass[11pt]{article}

\begin{document}
Olá mundo.
\end{document}
```

Essas linhas de código iniciam um documento do tipo artigo com fonte de tamanho 11 pt e imprimem "Olá mundo.'' na página. Todo o conteúdo dentro as linhas do `\begin{document` e o `\end{document}` aparecerá no documento, com exceção dos comentários marcados com um sinal de porcentagem (`%`). 

No entanto surgem alguns problemas com essa implementação, como o uso de acentos na Língua Portuguesa. Para isso serão utilizados mais três pacotes, o pacote [Babel](https://www.ctan.org/pkg/babel) cuida das especificidades e regras de determinada linguagem, o pacote [Inputenc](https://www.ctan.org/pkg/inputenc) cuida da codificação de entrada, como os acentos, (UTF-8) e o pacote [Fontenc](https://www.ctan.org/pkg/fontenc) da codificação de saída.

```Latex
\usepackage[brazilian]{babel} % Idioma Português-Brasil
\usepackage[utf8]{inputenc}   % Codificação de Entrada
\usepackage[T1]{fontenc}      % Codificação de Saída
```
Por último, adiciona-se os pacotes normalmente utilizados, como o [Fullpage](https://www.ctan.org/pkg/fullpage), que altera o tamanho das bordas para dar mais espaço ao texto, [Indentfirst](https://www.ctan.org/pkg/indentfirst), que cria um novo parágrafo a cada nova linha e o pacote [Graphicx](https://www.ctan.org/pkg/graphicx) que permite adicionar imagens.

```Latex
\usepackage{fullpage}      % Melhor uso da página
\usepackage{indentfirst}   % Autoidentar
\usepackage{graphicx}      % Importar figuras
```
O documento básico resultante deve ser da seguinte forma:

```Latex
%Início do documento
\documentclass[11pt]{article}

\usepackage[brazilian]{babel} % Idioma Português-Brasil
\usepackage[utf8]{inputenc}   % Codificação de Entrada
\usepackage[T1]{fontenc}      % Codificação de Saída

\usepackage{fullpage}         % Melhor uso da página
\usepackage{indentfirst}      % Autoidentar
\usepackage{graphicx}         % Importar figuras

\begin{document}
Olá mundo.
\end{document}
```


## Escrevendo Equações

Uma das partes fundamentais do LaTeX é a inserção de equações. Para isso, utiliza-se o ambiente *Mathmode*, indicado pelo caractere cifrão (`$`), onde pode-se escrever equações livremente utilizando a notação habitual. Desse modo, as equações serão inseridas dentro do texto.

Alternativamente, se você quiser que a equação tenha sua linha própria, pode-se dois cifrões  `$$` ou usar o comando `\begin{equation}`, que numerará as equações.

A seguir há alguns exemplos de uso.

----------
<center> `E = m c^2` </center>

$$ E = mc^2 $$

----------
<center> `E_r = \sqrt{ (m c^2)^2 + (pc)^2` </center>

$$ E_r = \sqrt{ (m c^2)^2 + (pc)^2 } $$


----------
<center> `x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}` </center>

$$ x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a} $$

----------
<center> `\int^{+\infty}_{-\infty} e^{x^2} dx = \sqrt{\pi}` </center>

$$ \int^{+\infty}_{-\infty} e^{x^2} dx = \sqrt{\pi} $$

----------

<center> `\sum_{n=1}^\infty \frac{1}{n^2} = \lim_{n \to \infty} \left( \frac{1}{1^2} + \frac{1}{2^2} + \cdots + \frac{1}{n^2} \right) = \frac{\pi^2}{6}` </center>

$$ \sum_{n=1}^\infty \frac{1}{n^2} = \lim_{n \to \infty}\left(\frac{1}{1^2} + \frac{1}{2^2} + \cdots + \frac{1}{n^2} \right) = \frac{\pi^2}{6} $$

----------
> **Nota:** Os símbolos especiais utilizados utilizam comandos precedidos com um barra (`\`— exemplo `\pi` para o número $\pi$). Para uma lista de símbolos e usos mais completa consulte [este artigo da Wikibooks](https://en.wikibooks.org/wiki/LaTeX/Mathematics).

## Títulos, Subtítulos e Referências Cruzadas

Uma das vantagens do LaTeX é a facilidade com a criação de seções, subseções e subsubseções. Para isso basta chamar o comando equivalente:

```Latex
\section{Seção 1}
\subsection{Subseção 1}
\subsubsection{Subsubseção 1}
```
Que irá produzir:

![numbers](https://cloud.githubusercontent.com/assets/8211602/20220105/5dc16d02-a813-11e6-9351-8da26ce6c2bb.png)

O resultado é numerado automaticamente. Cada vez que um comando com numeração é chamado (Seção, Subseção, Figura, etc), você pode colocar um **label** que poderá ser chamado no texto. Portanto, se você quiser referenciar determinada Seção ou Figura, não precisa se preocupar com a numeração em que eles aparecem. 

Para isso, utiliza-se o comando `\label{nome}` logo após criar a numeração. Para chamar a referência, basta usar o comando `\ref{nome}` Por exemplo:

```Latex
\section{Introdução} \label{sec:introducao}

Esta é a introdução. A Seção \ref{sec:desenvolvimento} tratará do desenvolvimento.

\section{Desenvolvimento} \label{sec:desenvolvimento}

Esse é o desenvolvimento, como descrito na Seção \ref{sec:introducao}.
```

Irá produzir:

![secao](https://cloud.githubusercontent.com/assets/8211602/20220137/7f509218-a813-11e6-9c3b-dbd5baf06c73.png)

> **Nota**: são necessárias **duas compilações** para o resultado desejado, pois na primeira todos os *labels* são processados e na segunda vez todas as *referências*.

## Sumário

A geração do sumário é simplificada utilizando o LaTeX. Para isso, basta utilizar o comando `\tableofcontents`. Para deixar o sumário em sua página própria, basta usar:

```Latex
\newpage
\tableofcontents
\newpage
```

## Inserindo Imagens

### Imagens Simples

Inserir imagens no LaTeX pode parecer uma tarefa árdua a princípio, já que elas são incluídas no código. Para isso, basta usar o comando `\includegraphics`. É recomendado usar um ambiente `figure` para isso. A seguir, há um exemplo de inserção de imagem. 

```Latex
\begin{figure}[!h]
\centering
\includegraphics[width=0.5\textwidth]{imagem.png}
\caption{Legenda da Imagem} \label{fig:imagem}
\end{figure}
```

Esse exemplo insere uma `imagem.png` centralizada com metade do tamanho do texto. De fato, a extensão `.png` pode ser suprimida. O `pdflatex` aceita nativamente os formatos **JPG**, **PNG**, **PDF** e **EPS**.

<div class="card"><img src="https://cloud.githubusercontent.com/assets/8211602/20220190/b668d1f2-a813-11e6-8238-da4c68f6dfab.png" /></div>

Usar a variável `\textwidth` para dimensionamento das imagens é interessante pois a imagem sempre respeitará as bordas de texto. Pode-se passar como parâmetro tamanhos como `width=1cm` ou `width=2in` para medidas exatas.

Você deve ter notado o parâmetro `[!h]` no ambiente `figure`. Isso indica ao LaTeX para *tentar* inserir a figura no local onde ela é chamada no texto. Caso isso não seja possível, o compilador irá deslocar a imagem para um local apropriado para não interromper o fluxo do texto. Outros parâmetros que podem ser utilizados são `b` (bottom), `t` (top). O caractere `!`indica que algumas restrições de posicionamento podem ser  ignoradas.

### Imagens Lado a Lado

Para adiciona imagens lado a lado, basta criar duas minipages e colocar uma imagem em cada. Para tal, pode-se usar a sequência de comandos:

```Latex
\begin{figure}[!h]
  \centering
  \begin{minipage}[b]{0.45\textwidth}
    \includegraphics[width=\textwidth]{imagem1}
    \caption{Primeira Imagem.}
  \end{minipage}
  \hfill
  \begin{minipage}[b]{0.45\textwidth}
    \includegraphics[width=\textwidth]{imagem2}
    \caption{Segunda Imagem.}
  \end{minipage}
\end{figure}

```

### Organizando uma pasta de imagens

Para adicionar imagens no texto, o arquivo deve estar localizado na pasta raiz do projeto (na mesma pasta do documento). No entanto, é mais útil e organizado criar uma pasta separada somente para imagens. Para adicionar a pasta `figuras`, basta usar o seguinte comando no preâmbulo.

```Latex
{% raw %}
\graphicspath{{./figuras/}}
{% endraw %}
```

## Formatação

Para formação do texto, pode-se usar funções como negrito, itálico e outros efeitos.


Função | Comando  | Resultado
-------- | -------- | -------- 
Negrito |`\textbf{Texto Exemplo}` | **Texto Exemplo**
Itálico   |`\textit{Texto Exemplo}`   | *Texto Exemplo*
Sublinhado | `\underline{Texto Exemplo}` | <u>Texto Exemplo</u>

> **Note:** Para mais estilos de fonte e tamanhos diferentes, cheque [esse tutorial no ShareLaTeX](https://pt.sharelatex.com/learn/Font_sizes,_families,_and_styles)


## Tabelas

As tabelas em LaTeX também podem ser geradas por código. Para tal, basta iniciar um `tabular`. As quebras de linhas são indicadas com o comando `\\`. Para melhorar os traços horizontais na tabela, utiliza-se o pacote [Booktabs](https://www.ctan.org/pkg/booktabs).

```Latex
\usepackage{booktabs}
```
Para criar uma tabela de três colunas

```Latex
\begin{table}[!h]
\renewcommand{\arraystretch}{1.3} % Ajusta espaçamento
\centering
\begin{tabular}{c|c|c}  % 3 Elementos Centralizados
% Utilize as 'rules' para traços na tabela
\toprule
Potência &      n      & $\pi(n)$ \\ \midrule
1  &    10             &  4       \\
2  &	100 	       &  25 	  \\
3  &	1,000          &  168 	  \\
4  &	10,000         &  1,229   \\
5  &	100,000        &  9,592   \\
\toprule \bottomrule
\end{tabular}
\caption{Distribuição de Primos $\pi(x)$} 
\label{tab:tabela}
\end{table}
```

Irá produzir:

![tabela](https://cloud.githubusercontent.com/assets/8211602/20220307/28ae561a-a814-11e6-9b04-e9caad4a8062.png)

## Exemplo

Nesse exemplo será construído um documento simples multiuso para trabalhos simples em LaTeX com os conteúdos abordados nesse documento. 

<style>
.button {
  display: inline-block;
  border-radius: 6px;
  background-color: #010740;
  border: 1px;
  color: #FFFFFF;
  text-align: center;
  font-size: 18px;
  padding: 16px;
  width: 200px;
  transition: all 0.5s;
  cursor: pointer;
  margin: 5px;
  -webkit-appearance: button;
}

.button span {
  cursor: pointer;
  display: inline-block;
  position: relative;
  transition: 0.5s;
}

.button span:after {
  content: '»';
  position: absolute;
  opacity: 0;
  top: 0;
  right: -20px;
  transition: 0.5s;
}

.button:hover span {
  padding-right: 25px;
}

.button:hover span:after {
  opacity: 1;
  right: 0;
}
</style>
</head>
<body>

<center>
<button onclick="window.open('https://www.overleaf.com/latex/templates/tex-template-simples-sem-capa/fjnhqxrqfgcg', '_blank');" class="button" style="vertical-align:middle"><span> Editar Online </span></button>
</center>

{% raw %}
```Latex
\documentclass[11pt]{article}

% Fonte em português brasileiro
\usepackage[brazilian]{babel}
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage{lmodern}

% Identação e Margens
\usepackage{fullpage}      % Margens
\usepackage{indentfirst}   % Autoidentar

% Figuras
\usepackage{graphicx}       % Pictures
\graphicspath{{./figuras/}} % Path

\begin{document}
% Cabeçalho simples
\noindent Aluno 1 \hfill Matrícula 1
\noindent Aluno 2 \hfill Matrícula 2

\noindent \textbf{Relatório 1: }
\noindent \rule{\linewidth}{1.5pt}

% Início do texto
\section{Introdução}

Esta é uma introdução.

\section{Conclusão}

Esta é uma conclusão.

\end{document}

```
{% endraw %}
