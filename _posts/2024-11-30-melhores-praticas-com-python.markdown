---
published: true
title: "Boas práticas com Python"
layout: post
abstract: O meu ponto de vista sobre como desenvolver código conciso e legível.
---

> O meu ponto de vista sobre como desenvolver código conciso e legível.

----------
* auto-gen TOC:
{:toc}
----------

# Introdução

Não há dúvidas de que Python é uma das linguagens mais fáceis para
iniciantes. [No artigo anterior](./2020-03-15-resolvendo-problemas-com-python.markdown),
discutimos como um Sudoku pode ser resolvido com apenas algumas linhas de código. No entanto, como tio Ben uma vez
disse,
*com grandes poderes vêm grandes responsabilidades*. Esse artigo é uma compilação de algumas dicas de como desenvolver
sem ser levado à completa loucura.

# Zen do Python

Há um certo *easter egg* na linguagem introduzido pela [PEP20](https://peps.python.org/pep-0020/) quando você importa
o pacote com `import this` (tradução retirada da [Wikipedia](https://pt.wikipedia.org/wiki/Zen_de_Python)):

> The Zen of Python, by Tim Peters
>
> - Bonito é melhor que feio.
> - Explícito é melhor que implícito.
> - Simples é melhor que complexo.
> - Complexo é melhor que complicado.
> - Linear é melhor do que aninhado.
> - Esparso é melhor que denso.
> - Legibilidade conta.
> - Casos especiais não são especiais o bastante para quebrar as regras.
> - Ainda que praticidade vença a pureza.
> - Erros nunca devem passar silenciosamente.
> - A menos que sejam explicitamente silenciados.
> - Diante da ambiguidade, recuse a tentação de adivinhar.
> - Dever haver um — e preferencialmente apenas um — modo óbvio para fazer algo.
> - Embora esse modo possa não ser óbvio a princípio a menos que você seja holandês.
> - Agora é melhor que nunca.
> - Apesar de que nunca normalmente é melhor do que *exatamente* agora
> - Se a implementação é difícil de explicar, é uma má ideia
> - Se a implementação é fácil de explicar, pode ser uma boa ideia
> - Namespaces são uma grande ideia — vamos ter mais dessas!

Muitas vezes existe a tentação enorme de pular muitos dessas dicas. Às vezes, nos deparamos com variáveis que não
conseguimos decidir por um bom nome, ou funções que são muito grandes, mas não temos ideia ou tempo para refatorar.
A tentação muitas vezes é grande para deixar ferramentas de inteligência artificial fazer funções inteiras, sem
entender o código escrito.

Como um desenvolvedor, seu trabalho é chegar em um equilíbrio: como conciliar todos esses desafios?

# Mudando, mas sem mudar

A primeira parte das dicas de boas práticas é dedicada à todas as práticas que não alteram uma linha de funcionalidade
no seu código (com sorte!). Essas são as dicas que você pode implementar imediatamente com o mínimo de refatoramento.

## Mantenha-se atualizado

Pode parecer bobo, mas atualizar constantemente seu interpretador vai te trazer inúmeros benefícios, o mais relevante
deles sendo o desempenho e segurança. Exceto se você for um banco que precisa manter código de 60 anos
funcionando (creio que não seja), vale atualizar-se nas novas funcionalidades das versões.

## Use formatadores

Qual o melhor tipo de indentação, espaços ou tabs? Quantos espaços usar? Uso snake_case ou camelCase? Que ordem coloco
meus imports?

Não importa! Use um formatador e pronto.

Sério, todo mundo gosta pretensiosamente de pensar que seu jeito de escrever código é o melhor, e fim de papo. Mas a
realidade é que o que é confortável para um não é para o outro. Por isso, autoformatadores garantem que se código
vai ser o mesmo independentemente de quem o escreve.

Um desses formatadores é o [black](https://github.com/psf/black). Experimente no
[black playground](https://black.vercel.app) como um formatador pode transformar seu código

Antes de formatar:

```python
def very_important_function(template: str, *variables, file: os.PathLike, debug: bool = False, ):
    """Applies `variables` to the `template` and writes to `file`."""
    with open(file, "w") as f:
        ...
```

Após formatar:

```python
def very_important_function(
        template: str,
        *variables,
        file: os.PathLike,
        debug: bool = False,
):
    """Applies `variables` to the `template` and writes to `file`."""
    with open(file, "w") as f:
        ...
```

Outro formatador (e linter) é o [ruff](https://github.com/astral-sh/ruff), que além de formatar outras seções de código
e ser compatível com o Black, também é capaz de executar regras de melhores práticas e uniformidade. Por exemplo, você
já deve saber que no Python é possível criar dicionários de duas formas:

- `{"foo": "bar}`
- `dict(foo="bar")`

Isso não é exatamente compatível com o Zen do Python:

> Dever haver um — e preferencialmente apenas um — modo óbvio para fazer algo.

O ruff garante, com regras, que somente uma dessas formas (a primeira) será utilizada no seu código, eliminando assim
disparidades de implementação.

Outra ferramenta interessante e amplamente utilizada é o [isort](https://github.com/PyCQA/isort), que uniformiza como
seus imports devem ser utilizados: qual a ordem, e como são utilizados. Ele vai, por exemplo, organizar seus imports
de forma alfabética, automaticamente agrupar imports do mesmo pacote e mover imports absolutos acima dos parciais.

Todos os três formatadores que citei são compatíveis com [pre-commit](https://pre-commit.com/), que garante que todos
serão executados a cada commit no seu repositório, evitando assim que outros desenvolvedores empurrem código não
formatado e que não cumpram as regras de formatação. Adicionalmente, você pode adicionar o pre-commit na CI para 
executar nos *pull requests*, te avisando de PRs mal formatados.

# Sistema de tipos

A linguagem tira as barreiras do
[sistema de tipos](https://pt.wikipedia.org/wiki/Sistema_de_tipos) (ou *static typing*), sendo possível que um objeto
tenha vários tipos diferentes durante execução do programa. Por exemplo, a seguinte função consegue ser executada
com múltiplos tipos de entrada:

```python
def somar(a, b):
    return a + b

somar(1, 2)  # Resulta em 3
somar("1", "2")  # Result em "12"
somar(True, False)  # Resulta em 1
somar("1", 1)  # Resulta em TypeError: can only concatenate str (not "int") to str
```

No entanto, o que é para ajudar, acaba piorando. Quem desenvolveu código na época do Python 2 sabe o desastre que pode
ser, e consegue entender o motivo de que muitas pessoas terem aversão ao Python. E após bastante tempo (tempo até
demais), o Python 3.5 adicionou [suporte para tipos](https://docs.python.org/3/library/typing.html).

Você deve estar se perguntando: cria-se uma linguagem sem tipos, e depois se adiciona tipagem, e um verificador de
tipos para checar se os tipos fazem sentido? Pode parecer contraintuitivo, mas esse foi o rumo que linguagens como o
Javascript (com [Typescript](https://www.typescriptlang.org/)) e Python (com [mypy](https://mypy-lang.org/)) tomaram.

Sem tipagem de variáveis, é bem possível que o seu código fique extremamente confuso, principalmente se você precisa
manter código que não é seu. Aliás, quem nunca voltou para o seu código depois de 6 meses para descobrir que não faz
mais idea do que determinadas funções recebem de parâmetros?

Com a tipagem correta (e assumindo que eu quero somar inteiros), o código acima pode ser escrito como:

```python
def somar(a: int, b: int) -> int:
    return a + b
```

## Use os tipos corretos

Faça a tipagem de modo mais específico possível. Por exemplo, ao declarar:

```python
def parse_txt_file(file: str) -> str:
    ...


def extract_file(file: str, file_type: str) -> str:
    if file_type == "txt":
        return parse_txt_file(file)
    ...
```

Fica óbvio na função acima quais os tipos que determinadas entradas devem ter, e o que devem retornar. 

Mas não fica claro que o `file_type` pode assumir apenas alguns valores
(como tipos de arquivos). Um melhor tipo para essa função seria usar o
[typing.Literal](https://docs.python.org/3/library/typing.html#typing.Literal):

```python
from typing import Literal


def extract_file(file: str, file_type: Literal["txt", "pdf", "xlsx"]) -> str:
    ...
```

Nesse caso, é diretamente claro quais tipos de arquivo a função suporta, sem ao menos olhar a implementação dela.

## Retorne objetos, não dicionários

Dê uma olhada no seguinte método:

```python
def parse_page(page: dict) -> dict:
    try:
        return {
            "metadata": page["page"].decode(),
            "page_num": page["page_num"],
        }
    except Exception as e:
        return {"error": f"Error processing page: {str(e)}"}
```

Pode parecer simples, e a tipagem está correta, mas ainda é impossível determinar corretamente qual o *formato* que a
entrada e saída devem ter. Fica muito melhor definir explicitamente com o que a função deve responder:

```python
from dataclasses import dataclass


@dataclass
class Page:
    page: bytes
    page_num: int


@dataclass
class ParsedPage:
    metadata: str
    page_num: int


def parse_page(page: Page) -> ParsedPage:
    try:
        return ParsedPage(page.page.decode(), page.page_num)
    except Exception as e:
        ...
```

Essa implementação define como os objetos devem ser, não sendo necessário checar se o dicionário tem os campos certos.

## Evite múltiplos tipos

Na implementação acima, existe também a possibilidade de a execução gerar um erro, por exemplo, ao passar um dicionário
vazio:

```python
def parse_page(page: dict) -> dict:
    try:
        return {
            "metadata": page["page"].decode(),
            "page_num": page["page_num"],
        }
    except Exception as e:
        return {"error": f"Error processing page: {str(e)}"}


parsed_page = parse_page({})
print(parsed_page["metadata"])  # Returna um erro! O objeto só tem o campo "error"
```

Em geral, não é preferível que seu objeto de retorno varie absurdamente dependendo do input. Como por norma (e
obviamente com algumas exceções), eu costumo fazer uma função retornar um tipo, com no máximo dois tipos:

- Um tipo esperado da função.
- Em alguns casos `None`, deixando o tipo como opcional.
- Alternativamente, se a resposta não foi opcional, uma exceção é levantada.

Aqui estão as duas implementações possíveis com essa regra:

```python
from typing import Optional


# Returna None se a função falha
def parse_page(page: Page) -> Optional[ParsedPage]:
    try:
        return ParsedPage(page.page.decode(), page.page_num)
    except Exception as e:
        print(f"Error processing page: {str(e)}")
        return None


# Levanta uma exceção se a função falha
def parse_page(page: Page) -> ParsedPage:
    return ParsedPage(page.page.decode(), page.page_num)
```

## mypy

O verificador de tipos mais conhecido do Python é o [mypy](https://mypy-lang.org/), e ele garante que não há erros de
tipagem definidos no seu código. IDEs como o PyCharm já levam em consideração os tipos e mostram avisos quando eles
não são respeitados, mas o mypy leva transforma esses avisos em erros. Tomando o exemplo anterior,
definiríamos a função como:

```python
def somar(a: int, b: int) -> int:
    return a + b


somar("1", "2")  # Levanta avisos na IDE, mas funciona
somar(1, 2)  # Funciona sem avisos 
```

Nesse caso, é definido *explicitamente* quais os tipos que a função aceita, e qual o tipo que retorna. Se rodarmos o
`mypy test.py` com o código acima, obtemos:

Obtemos:

```
test.py:4: error: Argument 1 to "somar" has incompatible type "str"; expected "int"  [arg-type]
test.py:4: error: Argument 2 to "somar" has incompatible type "str"; expected "int"  [arg-type]
Found 2 errors in 1 file (checked 1 source file)
```

Não estou sugerindo que você use mypy, mas estou sugerindo que todas as suas funções, métodos tenham tipos de entrada
e retorno. Isso facilita e muito no desenvolvimento, além de facilitar a leitura.

Caso você esteja com tempo curto, bibliotecas como o [MonkeyType](https://github.com/Instagram/MonkeyType) podem ajudar
a escrever tipos para código já escrito.

# Não complique, descomplique

![](https://imgs.xkcd.com/comics/the_general_problem.png)

Outro erro bastante comum é fazer o chamado *overengineering*, tentando resolver um problem que nem ao menos existe, 
deixando o código menos legível, e muitas vezes mais lento.

## Evite a otimização prematura

Uma frase célebre de Donald Knuth, criador do TeX
([predecessor do LaTeX que já cobrimos aqui](./2016-11-10-introdu-o-ao-latex.markdown)) é a seguinte:

> Programmers waste enormous amounts of time thinking about, or worrying about, the speed of noncritical parts of their
> programs, and these attempts at efficiency actually have a strong negative impact when debugging and maintenance are
> considered. We should forget about small efficiencies, say about 97% of the time: premature optimization is the root of
> all evil. Yet we should not pass up our opportunities in that critical 3%.

Um exemplo bastante claro de otimização prematura, que já passou na cabeça de muitas pessoas (inclusive na minha), é de
resolver qual a função deve ser executada com base em um dicionário.

Nesse caso, a função executada depende do parâmetro que foi passado para a função:

```python
import typing


def function_dict(v: str, param: typing.Literal["a", "b", "c"]):
    methods = {
        "a": lambda x: fn_1(x),
        "b": lambda x: fn_2(x),
        "c": lambda x: fn_3(x),
    }
    return methods[param](v)
```

Essa é uma reimplementação do clássico *if-else*:

```python
import typing


def function_if(v: str, param: typing.Literal["a", "b", "c"]):
    if param == "a":
        return fn_1(v)
    elif param == "b":
        return fn_2(v)
    elif param == "c":
        return fn_3(v)
```

Ou, caso você rode Python 3.10 ou superior, um *match-case*:

```python
import typing


def function_case(v: str, param: typing.Literal["a", "b", "c"]):
    match param:
        case "a":
            return fn_1(v)
        case "b":
            return fn_2(v)
        case "c":
            return fn_3(v)
```

```python
import time
import typing


def fn(x):
    return x


def function_dict(v, param):
    methods = {
        "a": lambda x: fn(x),
        "b": lambda x: fn(x),
        "c": lambda x: fn(x),
    }
    return methods[param](v)


def function_if(v, param):
    if param == "a":
        return fn(v)
    elif param == "b":
        return fn(v)
    elif param == "c":
        return fn(v)


def function_case(v: str, param: typing.Literal["a", "b", "c"]):
    match param:
        case "a":
            return fn(v)
        case "b":
            return fn(v)
        case "c":
            return fn(v)


t = time.perf_counter()
timed_fn = function_dict
for _ in range(10_000_000):
    timed_fn(1, "c")
t_elapsed = time.perf_counter() - t
print(f"Tempo para {timed_fn.__name__}: {t_elapsed:.1f}s")
```

Variando as funções obtemos:

- Tempo para function_dict: 3.3s
- Tempo para function_if: 0.9s
- Tempo para function_case: 0.9s

Fica bem claro que, ao usar o dicionário, não só deixar o código mais difícil de entender, ele ficou mais lento.

Otimização é extremamente importante, e é um assunto que ainda quero abordar, mas para otimização é necessário um 
objetivo específico em mente, e partindo de um tempo de execução de referência. Não há sentido em otimizar apenas como
o intuito de... otimizar, sem benefícios concretos.

## Use ferramentas da linguagem

Se a linguagem oferece ferramentas, use-as! Aqui vai um exemplo de uma implementação com sintaxe parecida com o C:

```python
i = 0
alphabet = ["a", "b", "c", "d", "e"]
while i < 5:
    print(i, alphabet[i])
    i = i + 1
```

Se você usa a linguagem por algum tempo, vai perceber que é possível simplificar usando o `range`:

```python
alphabet = ["a", "b", "c", "d", "e"]
for i in range(5):
    print(i, alphabet[i])
```

Mas um programador mais experiente vai perceber que essa funcionalidade é suportada com `enumerate`:

```python
alphabet = ["a", "b", "c", "d", "e"]
for i, letter in enumerate(alphabet):
    print(i, letter)
```

Três implementações diferentes, sendo a última mais concisa e fácil de entender.

## Evite aninhamento

O aninhamento ou *nesting* é quando suas funções tem muitas e muitas indentações dentro dela. Se você tem que 
apertar Tab muitas vezes, algo pode estar errado.

Um exemplo é o abaixo, onde fica difícil ler a função, e onde ela retorna no fluxo normal, rapidamente:

```python
def get_user_from_database(user_id: str) -> str | None:
    if user_id is not None:
        return User(user_id)
    else:
        return None


def function(user_id: str) -> User:
    user = get_user_from_database(user_id)
    if user:
        if user.has_permissions():
            return user
        else:
            raise ValueError("user does not have permissions")
    else:
        raise ValueError("User not found")
```

Nossos olhos instintivamente percorrem até o final da função para encontrar o valor de retorno, nesse caso sem 
encontrar nada. Uma alternative e implementar o retorno rápido: **se algo deu errado, retorne imediatamente**.

Na prática, o teste de condições é feito em etapas. A primeira função seria:

```python
def get_user_from_database(user_id: str) -> str | None:
    if user_id is None:
        return None
    return User(user_id)
```

Nesse caso, o retorno é explícito, e caso algo dê errado, o retorno ocorrerá antes. No segundo caso a mesma coisa:

```python
def function(user_id: str) -> User:
    user = get_user_from_database(user_id)
    if not user:
        raise ValueError("User not found")
    if not user.has_permissions():
        raise ValueError("user does not have permissions")
    return user
```

Essa técnica pode diminuir a complexidade de leitura e ajudar a entender a função mais rapidamente.

# Conclusão

Essas foram algumas dicas de como usar o Python, mas ficam algumas dicas extras como leitura.

Em primeiro lugar, as [funções padrão do Python](https://docs.python.org/3/library/functions.html) são um bom ponto de
partida para entender o que é suportado pela linguagem. Eu descrevi o uso do `enumerate` e `range`, mas outros também
são bastante utilizados, como o `zip`, `sum`, `all` e `any`, que valem a pena serem aprendidos.

Outra ferramente importante é o uso dos métodos mágicos, 
ou [dunder methods](https://realpython.com/python-magic-methods/), que implementam como classes interagem com as 
operações. Você já deve saber que pode implementar a formatação de texto especial de um objeto re-implementando o
método `__str__`, mas você sabia que também pode implementar como um objeto soma com outro objeto implementando o 
`__add__` e o `__radd__`?

Por fim, vale dizer que é um eterno aprendizado. Novas funcionalidades são desenvolvidas constantemente, e é necessário
continuar sempre aprendendo!
