---
published: true
title: O Universo Bitcoin 
layout: post
---

> Esse artigo tem o intuito de explicar o funcionamento das criptomoedas, em especial a mais famosa delas: o [Bitcoin](https://www.bitcoin.com/). 

----------

## Introdução

A primeira ideia de criptomoeda surgiu em 2008 em um pequeno artigo de Satoshi Nakamoto entitulado ["Bitcoin: A peer-to-peer electronic cash system"](https://bitcoin.org/bitcoin.pdf). Embora ninguém realmente saiba a identidade verdadeira de Nakamoto, seu artigo de apenas 9 páginas revolucionou o mundo das moedas digitais.

A ideia geral das criptomoedas é bem simples: manter todas as transações e carteiras seguras através de criptografia, mantendo todos os usuários cientes do banco de dados. Em palavras mais simples, o sistema não é baseado em confiança, e sim em prova criptográfica.

Em palavras ainda mais simples: ao realizar um pagamento, há uma relação de confiança. Geralmente, se confia no banco utilizado como terceiro elemento para intermediar o pagamento. Nesse caso, o banco é responsável por ficar com seu dinheiro e mover de conta em conta. É necessário que ambas as partes confiem no banco.

Mas isso mudou em 31 de outubro de 2008, com a introdução de um sistema capaz de, através de criptografia, permitir transações sem a necessidade de terceiros. E esse é um serviço comunitário: para que uma transação seja aceita, ela tem que ser adicionada à algum bloco, e é aí que entram os mineradores de Bitcoin, trabalhando para manter os blocos consistentes.

Para primeiro entender como isso é feito, deve-se entender o que é uma **função hash**.

## Funções Hash

A função hash, em poucas palavras, é uma função matemática não reversível que gera uma saída de tamanho fixo para uma determinada entrada. 

Um exemplo bem simples de função hash que transorma um número decimal em um outro de tamanho unitário é somar todos os algarismos e calcular o resto da divisão por 10. Nesse contexto, aplicar a nossa função hash no número **403** gera **7**, pois é **4 + 0 + 3 = 7**, e o resto dessa divisão por 10 é **7**. Se aplicado a **5454**, a função hash é **8**, pois **5 + 4 + 5 + 4 = 18**, e o resto da divisão por 10 é **8**. Note que essa função não é reversível: não existe meio de se obter o número original através do valor hash, pois parte da informação é perdida no processo.

Uma função hash tem diversos usos, mas geralmente algumas propriedades são esperadas, como:

- **Determinismo**, onde um valor sempre gera a mesma hash.
- **Distribuição uniforme**, de forma que não sejam gerados muitos valores similares.
- **Rápida de ser gerada**, mas não tão rápida que possa ser computada aos milhares facilmente.
- É impraticável achar a entrada original a partir da hash.
- É impraticável achar duas entradas com a mesma hash.
- Uma pequena mudança no valor de entrada causa uma grande mudança no valor da hash.

Abaixo há uma caixa de texto que computa um algoritmo de hash famoso, o [SHA256](https://en.wikipedia.org/wiki/SHA-2), utilizado como algoritmo da Bitcoin.

<div class="fancybox">
<h3>SHA256</h3>
<input type="text" id="myInput" style="width: 100%; height: 40px; font-size:22px;" oninput="myFunction()">
<p id="sha-output" style="font-size: 16px;"></p>
<script src="https://cdn.rawgit.com/chrisveness/crypto/9a15aa9/sha256.js"></script>
<script>
function myFunction() {
    var x = document.getElementById("myInput").value;
    var hash = Sha256.hash(x);
    document.getElementById("sha-output").innerHTML = hash;
}
</script>
</div>


Vamos analisar rapidamente a função hash SHA256. As colisões são no mínimo improváveis. Como a saída possui sempre 256 bits, as possibilidades são 2<sup>256</sup>, que é aproximadamente 10<sup>77</sup> ou 1 seguido de 77 zeros. Isso quer dizer que pode-se atribuir uma hash distinta para cada conjunto de 1000 átomos no universo.
