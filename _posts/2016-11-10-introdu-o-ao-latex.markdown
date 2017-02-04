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


> Esse é um documento de introdução ao LaTeX. Para ver um exemplo de documento <i class="fa fa-file-pdf-o fa-fw" aria-hidden="true"></i>[clique aqui](https://github.com/bvanelli/texdefault/raw/master/build/standard_output.pdf).

----------
* auto-gen TOC:
{:toc}
----------

O LaTeX (pronunciado ''*Lah-tek*'') é uma ferramenta de preparação de textos de alta qualidade usado normalmente na publicação de trabalhos técnicos e científicos. O objetivo do LaTeX não é ser uma ferramenta de processamento de textos gráfica, mas sim uma linguagem onde o usuário se foca apenas em escrever, e deixa o programa lidar com os estilos dos títulos, subtítulos, referências, etc.

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

```TeX
% Início do documento
\documentclass[11pt]{article}

\begin{document}
Olá mundo.
\end{document}
```

Essas linhas de código iniciam um documento do tipo artigo com fonte de tamanho 11 pt e imprimem ''Olá mundo.'' na página. Todo o conteúdo dentro as linhas do `\begin{document` e o `\end{document}` aparecerá no documento, com exceção dos comentários marcados com um sinal de porcentagem (`%`).

As linhas antes do `\begin{document}` fazem parte do preâmbulo. Ele é geralmente utilizado para importar pacotes ou definir comandos.

No entanto, surgem alguns problemas com esse código, já que não permite o uso de acentos da Língua Portuguesa. Para isso serão utilizados mais três pacotes, o pacote [Babel](https://www.ctan.org/pkg/babel) que cuida das especificidades e regras de determinada linguagem, o pacote [Inputenc](https://www.ctan.org/pkg/inputenc) que cuida da codificação de entrada, como os acentos, e o pacote [Fontenc](https://www.ctan.org/pkg/fontenc) da codificação de saída.

```TeX
\usepackage[brazilian]{babel} % Idioma Português-Brasil
\usepackage[utf8]{inputenc}   % Codificação de Entrada
\usepackage[T1]{fontenc}      % Codificação de Saída
```
Por último, adiciona-se os pacotes normalmente utilizados, como o [Fullpage](https://www.ctan.org/pkg/fullpage), que altera automaticamente o tamanho das bordas para dar mais espaço ao texto, [Indentfirst](https://www.ctan.org/pkg/indentfirst), que cria um novo parágrafo a cada nova linha e o pacote [Graphicx](https://www.ctan.org/pkg/graphicx) que permite adicionar imagens.

```TeX
\usepackage{fullpage}      % Melhor uso da página
\usepackage{indentfirst}   % Autoidentar
\usepackage{graphicx}      % Importar figuras
```
O documento básico resultante deve ser da seguinte forma:

```TeX
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

Uma das partes fundamentais do LaTeX é a inserção de equações. Para isso, utiliza-se o ambiente *Mathmode*, normalmente colocando o texto matemático entre dois cifrões (`$`), onde pode-se escrever equações livremente utilizando a notação habitual. Desse modo, as equações serão inseridas sem interromper o fluxo de texto.

Alternativamente, se você quiser que a equação tenha sua linha própria, como em equações longas, pode-se utilizar dois  cifrões  `$$` de cada lado ou usar o comando `\begin{equation}`, que também numerará as equações. É interessante que o LaTeX numera todas as equações, figuras e tabelas automaticamente. Não é necessário se preocupar se uma figura vem antes da outra, já que a numeração é feita pelo compilador.

A seguir há alguns exemplos de uso.

----------
`E = m c^2`

$$ E = mc^2 $$

----------
`E_r = \sqrt{ (m c^2)^2 + (pc)^2`

$$ E_r = \sqrt{ (m c^2)^2 + (pc)^2 } $$

----------
`x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}`

$$ x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a} $$

----------
`\int^{+\infty}_{-\infty} e^{x^2} dx = \sqrt{\pi}`

$$ \int^{+\infty}_{-\infty} e^{x^2} dx = \sqrt{\pi} $$

----------
`\sum_{n=1}^\infty \frac{1}{n^2} = \lim_{n \to \infty} \left( \frac{1}{1^2} + \frac{1}{2^2} + \cdots + \frac{1}{n^2} \right) = \frac{\pi^2}{6}`

$$ \sum_{n=1}^\infty \frac{1}{n^2} = \lim_{n \to \infty}\left(\frac{1}{1^2} + \frac{1}{2^2} + \cdots + \frac{1}{n^2} \right) = \frac{\pi^2}{6} $$

----------
> <i class="fa fa-book fa-fw" aria-hidden="true"></i> **Nota:** Os símbolos especiais utilizados utilizam comandos precedidos com um barra (`\`— exemplo `\pi` para o número Pi). Para uma lista de símbolos e usos mais completa consulte [este artigo da Wikibooks](https://en.wikibooks.org/wiki/LaTeX/Mathematics).

----------


## Títulos, Subtítulos e Referências Cruzadas

Uma das vantagens do LaTeX é a facilidade com a criação de **seções**, **subseções** e **subsubseções**. Para isso basta chamar o comando equivalente:

```TeX
\section{Seção 1}
\subsection{Subseção 1}
\subsubsection{Subsubseção 1}
```

Que irá produzir:

<img src="https://cloud.githubusercontent.com/assets/8211602/20220105/5dc16d02-a813-11e6-9351-8da26ce6c2bb.png" style="width: 85%;"/>

O resultado é numerado automaticamente. Além disso, cada vez que um comando com numeração é chamado (Seção, Subseção, Figura, etc), você pode colocar um **label** (ou rótulo) que identifica o elemento e pode ser chamado no texto. Portanto, se você quiser referenciar determinada Seção ou Figura, não precisa se preocupar com a numeração em que eles aparecem, basta chamar o rótulo que você criou. 

Para isso, utiliza-se o comando `\label{nome}` logo após criar a numeração. Para chamar a referência, basta usar o comando `\ref{nome}`. É interessante, mas não obrigatório, utilizar um prefixo nos nomes para identificar o que você está referenciando, como **sec** para seções ou **fig** para figuras. Por exemplo:

```TeX
\section{Introdução} \label{sec:introducao}

Esta é a introdução. A Seção \ref{sec:desenvolvimento} tratará do desenvolvimento.

\section{Desenvolvimento} \label{sec:desenvolvimento}

Esse é o desenvolvimento, como descrito na Seção \ref{sec:introducao}.
```

Irá produzir:

![secao](https://cloud.githubusercontent.com/assets/8211602/20220137/7f509218-a813-11e6-9c3b-dbd5baf06c73.png)

> <i class="fa fa-book fa-fw" aria-hidden="true"></i> **Nota**: são necessárias **duas compilações** para o resultado desejado, pois na primeira todos os *labels* são processados e na segunda vez todas as *referências*.

## Sumário

A geração do sumário é simplificada utilizando o LaTeX. Para isso, basta utilizar o comando `\tableofcontents`. Para deixar o sumário em sua página própria, basta usar `\newpage`:

```TeX
\newpage
\tableofcontents
\newpage
```

## Inserindo Imagens

### Imagens Simples

Inserir imagens no LaTeX pode parecer uma tarefa árdua a princípio, já que elas são incluídas no código. Para isso, basta usar o comando `\includegraphics`. É recomendado usar um ambiente `figure` para isso. A seguir, há um exemplo de inserção de imagem. 

```TeX
\begin{figure}[!h]
\centering
\includegraphics[width=0.5\textwidth]{imagem.png}
\caption{Legenda da Imagem} \label{fig:imagem}
\end{figure}
```

Esse exemplo insere uma `imagem.png` centralizada com metade do tamanho do texto. De fato, a extensão `.png` pode ser suprimida. O `pdflatex` aceita nativamente os formatos **JPG**, **PNG**, **PDF** e **EPS**.

<img src="https://cloud.githubusercontent.com/assets/8211602/20220190/b668d1f2-a813-11e6-8238-da4c68f6dfab.png" style="width: 85%;"/>

Usar a variável `\textwidth` para dimensionamento das imagens é interessante pois a imagem sempre respeitará as bordas de texto (incluindo texto escrito em duas colunas). Pode-se passar como parâmetro tamanhos como `width=1cm` ou `width=2in` para medidas exatas.

Você deve ter notado o parâmetro `[!h]` no ambiente `figure`. Isso indica ao LaTeX para *tentar* inserir a figura no local onde ela é chamada no texto. Caso isso não seja possível, o compilador irá deslocar a imagem para um local apropriado para não interromper o fluxo do texto. Outros parâmetros que podem ser utilizados são `b` (bottom), `t` (top). O caractere `!`indica que algumas restrições de posicionamento podem ser ignoradas (como em `[!htb]`, que posiciona a imagem em qualquer lugar).

### Imagens Lado a Lado

Para adiciona imagens lado a lado, basta criar duas minipages e colocar uma imagem em cada. Para tal, pode-se usar a sequência de comandos:

```TeX
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

Para adicionar imagens no texto, o arquivo deve estar localizado na pasta raiz do projeto (na mesma pasta do documento). No entanto, é mais útil e organizado criar uma pasta separada somente para imagens. Para adicionar a pasta `figuras` nas pastas onde o LaTeX procurará por imagens, basta usar o seguinte comando no preâmbulo.

```TeX
{% raw %}\graphicspath{{./figuras/}}{% endraw %}
```

## Formatação

Para formação do texto, pode-se usar funções como negrito, itálico e outros efeitos.


Comando  | Resultado
-------- | -------- 
`\textbf{Texto Exemplo}` | **Texto Exemplo**
`\textit{Texto Exemplo}`   | *Texto Exemplo*
`\underline{Texto Exemplo}` | <u>Texto Exemplo</u>

> <i class="fa fa-book fa-fw" aria-hidden="true"></i> **Nota:** Para mais estilos de fonte e tamanhos diferentes, cheque [esse tutorial no ShareLaTeX](https://pt.sharelatex.com/learn/Font_sizes,_families,_and_styles).


## Tabelas

As tabelas em LaTeX também podem ser geradas por código. Para tal, basta iniciar um `tabular`. As quebras de linhas são indicadas com o comando `\\`. Para melhorar os traços horizontais na tabela, utiliza-se o pacote [Booktabs](https://www.ctan.org/pkg/booktabs) (`\toprule`, `\midrule` e `\bottomrule` irão traçar retas horizontais).

```TeX
\usepackage{booktabs}
```
Para criar uma tabela de três colunas, basta usar o seguinte código.

```TeX
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

<img src="https://cloud.githubusercontent.com/assets/8211602/20220307/28ae561a-a814-11e6-9b04-e9caad4a8062.png" style="width: 85%;"/>

## Exemplo

Nesse exemplo será construído um documento simples multiuso para trabalhos simples em LaTeX com os conteúdos abordados nesse documento. 


<center>
<button onclick="window.open('https://www.overleaf.com/latex/templates/tex-template-simples-sem-capa/fjnhqxrqfgcg', '_blank');" class="fancybutton" style="vertical-align:middle"><span> <i class="fa fa-desktop fa-fw" aria-hidden="true"></i> Editar Online </span></button>
</center>

```TeX
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
{% raw %}\graphicspath{{./figuras/}} % Path{% endraw %}

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

## Considerações Finais

Em primeiro lugar, **não se assuste**. O LaTeX pode parecer complicado à primeira vista por ter um paradigma muito diferente dos produtores de texto usuais. Tenha em mente que uma vez que o conhecimento básico foi dominado, será mais fácil e rápido fazer documentos em LaTeX pela despreocupação com os estilos de títulos e parágrafos, e principalmente ao digitar equações.

Para saber mais, consulte [mais códigos de exemplo](https://github.com/bvanelli/texdefault) disponibilizados na minha página do Github, [exemplos do Overleaf](https://www.overleaf.com/latex/templates) e o bom e velho Google.
