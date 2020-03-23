---
published: true
title: "Resolvendo problemas com Python: Sudoku"
layout: post
abstract: Esse pequeno artigo tenta explicar o poder que a linguagem Python tem para resolver problemas cotidianos de forma rápida.
---

> Esse pequeno artigo tenta explicar o poder que a linguagem Python tem para resolver problemas cotidianos de forma rápida.

----------
* auto-gen TOC:
{:toc}
----------

# Porque Python?

O Python é uma linguagem de alto-nível interpretada concebida na década de 1980 e finalmente implementada em sua primeira versão em 1991. Desde então, ela cresceu muito em número de usuários e ficou mais completa e simples de usar. O Python se baseia em alguns princípios definidos na [Zen do Python](https://mail.python.org/pipermail/python-list/1999-June/001951.html).

> The Zen of Python, by Tim Peters
> 
> Beautiful is better than ugly.
> Explicit is better than implicit.
> Simple is better than complex.
> Complex is better than complicated.
> Flat is better than nested.
> Sparse is better than dense.
> Readability counts.
> [...]

Como vocês podem ver, a linguagem é focada em ser limpa, concisa e legível, sem perder (muito) a sua velocidade de execução. Afinal, em muitos casos, de que adianta você conseguir rodar algo em C/C++ que é 100x mais rápido que o equivalente em Python, se você demoraria 10x menos para escrever a solução em Python? Se você pretende executar sua solução uma vez para automatizar uma tarefa repetitiva, a rapidez de desenvolvimento é muito mais importante que o tempo de execução.

De acordo com o [PYPL](https://pypl.github.io/PYPL.html) (*PopularitY of Programming Language*), que avalia a popularidade de linguagens de programação. O Python atualmente ocupa a primeira colocação como linguagem mais popular, tendo passado o Java e representando cerca de 30% das buscas no Google entre 22 linguagens. As fantásticas ferramentas incluídas em sua biblioteca padrão (dicionários, listas, operações de entrada e saída, manipulação de strings e objetos, etc) e nas bibliotecas desenvolvidas pela comunidade (plot de gráficos, ferramentas de análise de dados e machine learning, etc) foram as grandes responsáveis por esse sucesso. Muitas vezes, códigos que precisam de várias linhas em outras linguagens possam ser resumidas a uma ou duas linhas usando essas bibliotecas.

Para demonstrar o uso dessa linguagem na prática vamos tentar resolver um *sudoku* usando Python.
 
# O problema

O Sudoku é um jogo de lógica onde o jogador deve preencher um tabuleiro 9x9 com os números de 1 a 9 de forma que nenhuma linha, coluna ou quadrante tenha o mesmo número duas vezes. A Figura abaixo mostra um desses tabuleiros. A primeira imagem é um problema típico, onde as linhas finas dividem as células e as linhas mais grossas dividem os quadrantes.

![](https://upload.wikimedia.org/wikipedia/commons/thumb/e/e0/Sudoku_Puzzle_by_L2G-20050714_standardized_layout.svg/1024px-Sudoku_Puzzle_by_L2G-20050714_standardized_layout.svg.png)

A segunda imagem (abaixo) é um tabuleiro resolvido, com a resolução em vermelho.

![](https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/Sudoku_Puzzle_by_L2G-20050714_solution_standardized_layout.svg/1024px-Sudoku_Puzzle_by_L2G-20050714_solution_standardized_layout.svg.png)

# Resolvendo o problema

Iremos dividir a resolução do problema em várias partes: definindo o problema no Python, identificando as possibilidades das células, preenchendo as células e por fim retornando os resultados. Caso o leitor queira resolver por si mesmo o problema, essa é uma boa hora para parar de ler e por a mão na massa! Como um aviso: a resolução do problema vai ser apresentada da forma mais concisa e bonita possível, que definitivamente não foi a primeira solução que cheguei quando resolvi ele pela primeira vez!

## Definindo o problema

Vamos definir primeiro o Sudoku em uma matriz. O Python (claro) já tem uma biblioteca para utilização de matrizes, o [numpy](https://numpy.org/). Como já sabemos a resposta do Sudoku da figura acima, vamos utilizá-lo como teste, preenchendo o valor zero nas posições desconhecidas.

```python
import numpy as np

sudoku = np.array([5, 3, 0, 0, 7, 0, 0, 0, 0,
                   6, 0, 0, 1, 9, 5, 0, 0, 0,
                   0, 9, 8, 0, 0, 0, 0, 6, 0,
                   8, 0, 0, 0, 6, 0, 0, 0, 3,
                   4, 0, 0, 8, 0, 3, 0, 0, 1,
                   7, 0, 0, 0, 2, 0, 0, 0, 6,
                   0, 6, 0, 0, 0, 0, 2, 8, 0,
                   0, 0, 0, 4, 1, 9, 0, 0, 5,
                   0, 0, 0, 0, 8, 0, 0, 7, 9]).reshape([9, 9])
```

Assim, quando executamos `print(sudoku)` obtemos a matriz formatada (obrigado numpy!):

```
[[5 3 0 0 7 0 0 0 0]
 [6 0 0 1 9 5 0 0 0]
 [0 9 8 0 0 0 0 6 0]
 [8 0 0 0 6 0 0 0 3]
 [4 0 0 8 0 3 0 0 1]
 [7 0 0 0 2 0 0 0 6]
 [0 6 0 0 0 0 2 8 0]
 [0 0 0 4 1 9 0 0 5]
 [0 0 0 0 8 0 0 7 9]]
```

## Identificando inserções possíveis

Um número só pode ser inserido em uma posição se ele ainda não estiver na linha, coluna ou quadrante. 

Podemos retirar a linha de uma matriz com numpy facilmente usando `sudoku(linha, :)`. O mesmo ocorre com a coluna, usando notação semelhante, `sudoku(:, coluna)`. Para o quadrante, vamos escrever uma pequena função que retorna o quadrante inteiro.

```python
def quadrant(sudoku, x, y):
    xx = x // 3
    yy = y // 3
    return sudoku[xx * 3:(xx + 1) * 3, yy * 3:(yy + 1) * 3]
```

Assim, é possível testar se a inserção é válida usando o operador `in` do Python:

```python
def is_valid(sudoku, x, y, value):
    return value not in sudoku[x, :] and value not in sudoku[:, y] and value not in quadrant(sudoku, x, y)
```

Por fim, para retornar as possibilidades de uma determinada posição, basta testar os números de 1 a 9 na coordenada especificada:

```python
def possibilities(self, x, y):
    possibilities = list()
    for i in range(1, 10):
        if self.is_valid(x, y, i):
            possibilities.append(i)
    return possibilities
```

Para testar nosso código, vamos utilizar a posição do centro conforme a figura a seguir. O número inserido não pode estar na linha (em verde), coluna (em vermelho) ou quadrante (em azul). A única possibilidade é o número 5. Para essa posição.

![sudoku_one_possibility](https://user-images.githubusercontent.com/8211602/77355656-1e7e8300-6d45-11ea-92c5-672c244d2126.png)

Rodando o nosso algoritmo utilizando `print(possibilities(sudoku, 4, 4))`, vemos que de fato 5 é a única possibilidade.

## Preenchendo as células

Se você já jogou Sudoku sabe que preencher as células nem sempre é uma tarefa simples, como foi no nosso exemplo acima. Muitas vezes, há mais de uma possibilidade em todas as células e você deve simular se é possível resolver o problema escolhendo uma dessas possibilidades. Vamos primeiro percorrer a matriz e encontrar os lugares vagos (com valor igual a zero):

```python
def solver(sudoku, solutions):
    for (x, y), value in np.ndenumerate(sudoku):
        if value == 0:
	    # resolver a posição
```

Como já dizia o poeta, *"Só parte para a conversa quem não se garante na porrada."* Então, vamos usar a força bruta para resolver a posição desejada, tentando todas as possibilidades para a célula.

```python
def solver(sudoku, solutions):
    for (x, y), value in np.ndenumerate(sudoku):
        if value == 0:
            for possibility in possibilities(sudoku, x, y):
                sudoku[x, y] = possibility
```

Dada o novo sudoku com a célula já preenchida, resolvemos esse novo sudoku. Mas espere! Já sabemos resolver o sudoku, basta utilizar a função `solve()` que acabamos de criar. Portanto, chamamos ela novamente:

```python
def solver(sudoku, solutions):
    for (x, y), value in np.ndenumerate(sudoku):
        if value == 0:
            for possibility in possibilities(sudoku, x, y):
                sudoku[x, y] = possibility
                solver(sudoku, solutions)
```

Por fim, para caso a posição não for a correta, voltamos o sudoku para a posição original preenchendo-a com zero:

```
def solver(sudoku, solutions):
    for (x, y), value in np.ndenumerate(sudoku):
        if value == 0:
            for possibility in possibilities(sudoku, x, y):
                sudoku[x, y] = possibility
                solver(sudoku, solutions)
                sudoku[x, y] = 0
```

Isso vai fazer com que todas as posições do sudoku sejam testadas recursivamente. Caso o valor da célula seja zero e não haja nenhuma possibilidade para ela, então o sudoku não pode mais ser resolvido, nesse caso, retornamos sem fazer nada.

```python
def solver(sudoku, solutions):
    for (x, y), value in np.ndenumerate(sudoku):
        if value == 0:
            for possibility in possibilities(sudoku, x, y):
                sudoku[x, y] = possibility
                solver(sudoku, solutions)
                sudoku[x, y] = 0
            return
```

Caso tenhamos passado por todas as células do tabuleiro e nenhuma delas for zero, então o sudoku foi resolvido, nesse caso, adicionamos uma cópia da solução às soluções e continuamos a busca.

```python
def solver(sudoku, solutions):
    for (x, y), value in np.ndenumerate(sudoku):
        if value == 0:
            for possibility in possibilities(sudoku, x, y):
                sudoku[x, y] = possibility
                solver(sudoku, solutions)
                sudoku[x, y] = 0
            return
    solutions.append(sudoku.copy())
```

É isso! Já é possível resolver o sudoku com o algoritmo acima. Para isso, basta passar a nossa tabela que foi criada no início:

```python
solutions = list()

solver(sudoku, solutions)

for solution in solutions:
    print(solution)
```

E o resultado é o sudoku preenchido.

```
[[5 3 4 6 7 8 9 1 2]
 [6 7 2 1 9 5 3 4 8]
 [1 9 8 3 4 2 5 6 7]
 [8 5 9 7 6 1 4 2 3]
 [4 2 6 8 5 3 7 9 1]
 [7 1 3 9 2 4 8 5 6]
 [9 6 1 5 3 7 2 8 4]
 [2 8 7 4 1 9 6 3 5]
 [3 4 5 2 8 6 1 7 9]]
```

# Código completo

```python
import numpy as np


def is_valid(sudoku, x, y, value):
    return value not in sudoku[x, :] and value not in sudoku[:, y] and value not in quadrant(sudoku, x, y)


def quadrant(sudoku, x, y):
    xx = x // 3
    yy = y // 3
    return sudoku[xx * 3:(xx + 1) * 3, yy * 3:(yy + 1) * 3]


def possibilities(sudoku, x, y):
    possibilities = list()
    for value in range(1, 10):
        if is_valid(sudoku, x, y, value):
            possibilities.append(value)
    return possibilities


def solver(sudoku, solutions):
    for (x, y), value in np.ndenumerate(sudoku):
        if value == 0:
            for possibility in possibilities(sudoku, x, y):
                sudoku[x, y] = possibility
                solver(sudoku, solutions)
                sudoku[x, y] = 0
            return
    solutions.append(sudoku.copy())


if __name__ == '__main__':
    sudoku = np.array([5, 3, 0, 0, 7, 0, 0, 0, 0,
                       6, 0, 0, 1, 9, 5, 0, 0, 0,
                       0, 9, 8, 0, 0, 0, 0, 6, 0,
                       8, 0, 0, 0, 6, 0, 0, 0, 3,
                       4, 0, 0, 8, 0, 3, 0, 0, 1,
                       7, 0, 0, 0, 2, 0, 0, 0, 6,
                       0, 6, 0, 0, 0, 0, 2, 8, 0,
                       0, 0, 0, 4, 1, 9, 0, 0, 5,
                       0, 0, 0, 0, 8, 0, 0, 7, 9]).reshape([9, 9])
    solutions = list()
    solver(sudoku, solutions)
    for solution in solutions:
        print(solution)
```

E assim, com menos de 50 linhas e um código facilmente legível, conseguimos resolver o problema do sudoku! De fato, não é uma implementação leve. A função solve é chamada 4632 vezes! Além disso, a resolução demora um pouco menos de 250 ms. Sim, provavelmente seria mais rápido implementar as mesmas funções em C. Mas será que é realmente necessário? Bem, vai depender de para quem você pergunta.

# Extras

Você deve estar se perguntando porque utilizamos uma lista para adicionar as soluções. Isso é porque pode existir mais de uma solução por sudoku. Vamos remover dois número do sudoku anterior para ver o que acontece:

```python
sudoku = np.array([5, 3, 0, 0, 7, 0, 0, 0, 0,
                   6, 0, 0, 1, 9, 5, 0, 0, 0,
	           0, 9, 8, 0, 0, 0, 0, 6, 0,
	           8, 0, 0, 0, 0, 0, 0, 0, 3,
	           4, 0, 0, 8, 0, 3, 0, 0, 1,
	           7, 0, 0, 0, 2, 0, 0, 0, 6,
	           0, 6, 0, 0, 0, 0, 2, 8, 0,
	           0, 0, 0, 4, 1, 9, 0, 0, 5,
	           0, 0, 0, 0, 8, 0, 0, 7, 9]).reshape([9, 9])
```

Após resolvermos o problema, ele acha duas soluções:

```
[[5 3 4 6 7 8 9 1 2]
 [6 7 2 1 9 5 3 4 8]
 [1 9 8 3 4 2 5 6 7]
 [8 2 6 7 5 1 4 9 3]
 [4 5 9 8 6 3 7 2 1]
 [7 1 3 9 2 4 8 5 6]
 [9 6 1 5 3 7 2 8 4]
 [2 8 7 4 1 9 6 3 5]
 [3 4 5 2 8 6 1 7 9]]
[[5 3 4 6 7 8 9 1 2]
 [6 7 2 1 9 5 3 4 8]
 [1 9 8 3 4 2 5 6 7]
 [8 5 9 7 6 1 4 2 3]
 [4 2 6 8 5 3 7 9 1]
 [7 1 3 9 2 4 8 5 6]
 [9 6 1 5 3 7 2 8 4]
 [2 8 7 4 1 9 6 3 5]
 [3 4 5 2 8 6 1 7 9]]
```
