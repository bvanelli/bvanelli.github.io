---
published: true
title: A Matemática da Mega da Virada
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
          src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.1/MathJax.js">
</script>

> Na época de fim de ano, muitas pessoas voltam suas atenções para um evento probabilístico chamado Mega da Virada. Mas será que elas entendem a real chance de ganharem?

## A probabilidade

A Mega-sena é um evento da loteria brasileira em que, dentre 60 números, nomeados de 1 a 60, o jogador deve marcar uma quantidade entre 6 e 15 números. O vencedor do prêmio máximo é aquele que corretamente marca os 6 números sorteados. O preço da aposta é R$ 3,50, então esse tipo de sorteio acumulado no final do ano é visto por muitos como uma forma de enriquecer facilmente apenas na sorte.

Em termos matemáticos, é muito fácil calcular a chance de ganhar nesse evento. O número de cartões possíveis é dado pela combinação de 60, 6 a 6, ou:


Sua chance de acertar o cartão é **uma em cinquenta milhões, sessenta e três mil e oitocentos e sessenta**! Para jogar todos os cartões possíveis, você teria que desembolsar aproximadamente 175 milhões de reais.

O jogo ainda te dá a chance de jogar vários cartões de uma só vez em um cartão só, preenchendo mais de 6 números. Por exemplo, ao jogar 7 números, você estará jogando o equivalente a 7 cartões diferentes, e o preço do cartão subirá proporcionalmente. Não existe nenhuma vantagem em jogar 7 cartões ou 6 números ou 1 cartão com 7 números.

<div class="fancybox">
<h3 style="margin-top: 0rem; margin-bottom: 1rem">Probabilidade de Ganhar</h3>

<link href="https://cdnjs.cloudflare.com/ajax/libs/angularjs-slider/6.4.3/rzslider.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.6/angular.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/angularjs-slider/6.4.3/rzslider.min.js"></script>
<div ng-app="myapp">
  <div ng-controller="TestController as vm">
    <rzslider rz-slider-model="vm.totais.value" rz-slider-options="vm.totais.options" style="margin-bottom: 1rem"></rzslider>
    <rzslider rz-slider-model="vm.numeros.value" rz-slider-options="vm.numeros.options"></rzslider>
  </div>
</div>
<script>
var myApp = angular.module('myapp', ['rzModule']);

myApp.controller('TestController', TestController);

function TestController() {
  var vm = this;

  vm.totais = {
    value: 60,
    options: {
      floor: 6,
      ceil: 60,
	  onChange: function(id) {
        vm.numeros.options.maxLimit = vm.totais.value;
		if(vm.numeros.value > vm.totais.value)
			vm.numeros.value = vm.totais.value;
	  },
	  translate: function(value, sliderId, label) {
		switch(label) {
		  case 'model':
	        return '<b>Números totais</b>:' + value;
		  default:
			return value;
		}
	  }
    }
  }


  vm.numeros = {
    value: 6,
    options: {
      floor: 6,
      ceil: 60,
      maxLimit: vm.totais.value,
	  translate: function(value, sliderId, label) {
		switch(label) {
		  case 'model':
	        return '<b>Números jogados</b>:' + value;
		  default:
			return value;
		}
	  }
    }
  }

	
  vm.cartoes = {
    value: 1,
    options: {
      floor: 1,
      ceil: 50063860,
	  translate: function(value, sliderId, label) {
		switch(label) {
		  case 'model':
	        return '<b>Cartões jogados</b>:' + value;
		  default:
			return value;
		}
	  }
    }
  }
}
</script>

</div>
