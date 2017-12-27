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
<div style="margin-top: 1rem">Cartões totais do concurso: <b id="total_cards"></b></div>
<div>Cartões totais jogados: <b id="chosen_cards"></b></div>
<div>Preço da Aposta: <b id="preco"></b></div>
<div>Chance de ganhar: <b id="chance"></b></div>

<script>
var myApp = angular.module('myapp', ['rzModule']);

myApp.controller('TestController', TestController);

var f = [];
function factorial (n) {
  if (n == 0 || n == 1)
    return 1;
  if (f[n] > 0)
    return f[n];
  return f[n] = factorial(n-1) * n;
}

function updateProbability (t, n) {
  var cards = Math.round(factorial(t)/factorial(t-6)/factorial(6));
  var chosen_cards = Math.round(factorial(n)/factorial(6)/factorial(n-6));
  var preco = chosen_cards * 3.5;
  var chance = chosen_cards/cards*100;
  document.getElementById("total_cards").innerHTML = cards;
  document.getElementById("chosen_cards").innerHTML = chosen_cards;
  document.getElementById("preco").innerHTML = 'R$ ' + preco.toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,');;
  document.getElementById("chance").innerHTML = chance + '%';
}

function TestController() {
  var vm = this;

  vm.totais = {
    value: 60,
    options: {
      floor: 6,
      ceil: 70,
	  onChange: function(id) {
        vm.numeros.options.maxLimit = vm.totais.value;
		if(vm.numeros.value > vm.totais.value)
			vm.numeros.value = vm.totais.value;

        updateProbability(vm.totais.value, vm.numeros.value);
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
      ceil: 70,
	  onChange: function(id) {
        updateProbability(vm.totais.value, vm.numeros.value);
	  },
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

 updateProbability(vm.totais.value,vm.numeros.value);
}

</script>
</div>

## Todo número nasce igual... ou quase

<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.1/Chart.min.js"></script>
<script src="https://cdn.rawgit.com/jtblin/angular-chart.js/master/dist/angular-chart.min.js"></script>

<canvas id="myChart" width="400" height="400"></canvas>
<script>
var ctx = document.getElementById("myChart").getContext('2d');
var myChart = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: ["Red", "Blue", "Yellow", "Green", "Purple", "Orange"],
        datasets: [{
            label: 'Quantidade de Ocorrências',
            data: [12, 19, 3, 5, 2, 3],
            backgroundColor: [
                'rgba(54, 162, 235, 0.2)'
            ],
            borderColor: [
                'rgba(54, 162, 235, 1)'
            ],
            borderWidth: 1
        }]
    },
    options: {
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero:true
                }
            }]
        }
    }
});
</script>

