# ANOTAÇÕES DE ESTUDO SOBRE ELIXIR

## **CONCEITOS E VANTAGENS DA LINGUAGEM**

Elixir por ser uma linguagem funcional, ela tem como principal filosofia por assim dizer, a capacidade de solucionar problemas como:  

1. Imutabilidade  
    1.1 Redução de efeitos colaterais;
    1.2 Trabalha muito bem com uma grande concorrência e paralelismo de funcionamento;

2. Testes e codebase da linguagem são simples e altamente escaláveis;

3. Elixir trabalha com Erlang VM (BEAM)
    3.1 Possui alta disponibilidade e escalabilidade;
    3.2 Em 2018 rodava 90% de todo o tráfego da internet. Demonstrando o poder da linguagem para trabalho em concorrência e paralelimos;

4. Maior aproveitamento do poder computacional disponível;

&nbsp;

## **COMANDOS IMPORTANTES**

No terminal do elixir, pode usar comandos como: **Map. (TAB)**

O que isso faz ?
> Lista uma documentação para nós, das funções de Map padrões da linguagem e o mesmo para List e para todas as outras funções da linguagem como String, Float, Integer, Atom, etc.

&nbsp;

## **TIPOS PRIMITIVOS (BOOLEAN | STRING | FLOAT | INTEGER)**

O trabalho do Elixir em cima de tipos primitivos como Boolean, String, Float, Integer segue o padrão já estabelecida em outras linguagens de programação como PHP e JavaScript por um exemplo.

&nbsp;

## **LISTAS**

Diferentemente das outras linguagens, no **Elixir** as listas trabalham com ***encadeamento***, e por que isso ?

Bom, listas encadeadas não permitem um acesso direto aos valores armazenados na memória. E caso seja necessário acessar o segundo valor dessa lista, é obrigatório passar pelo primeiro índice da lista pois existe a seguinte ordem de execução:

```elixir
[1] -> [2] -> [3]
```

Ou seja, o primeiro índice é o responsável por encadear os demais e gerar a possibilidade de os acessar. Sem passar pelo primeiro não temos como validar o valor do segundo/terceiro índice e assim por diante.

&nbsp;

Uma lista pode conter valores:

1. Variados:

    ```elixir
    Input: [1, 2 , 3.5, "string"]
    Output: [1, 2, 3.5, "string"]
    ```

2. Somado/Concatenado:

    ```elixir
    Input: [1, 2, 3] ++ [4 ,5, 6]
    Output: [1, 2, 3, 4, 5, 6]
    ```

3. Substraída:

    ```elixir
    Input: [1, 2, 3] -- [2]
    Output: [1, 3]
    ```

&nbsp;

E como seria um exemplo de acesso/verificação dos elementos de uma lista?

```elixir
hd "retorna a cabeça, ou seja, o primeiro elemento da lista :"
    Input: hd([1, 2, 3])
    Output: 1

tl "retorna a cauda, ou seja, todos os elementos da lista menos o primeiro :"
    Input: tl([1, 2, 3])
    Output: [2, 3]
```

&nbsp;

### *IMUTABILIDADE EM LISTAS*

Como funciona a imutabilidade do **Elixir** nas listas ?  

&nbsp;

Para poder responder a pergunta de forma mais didática, vamos levar em consideração o código abaixo:

```elixir
x = [1, 2, 3]
x = [1, 2, 3] ++ [4]
```

O que acontece aqui neste código?  
Nós estamos fazendo uma concatenação/soma da lista ``[1, 2, 3]`` e ``[4]``. O que vai acontecer nesse caso ? Em memória, nós teremos 2 listas criadas, a lista de X e ``[4]``, eles não sofrerão alteração, o que vai acontecer é:
> Um apontamento para o local de memória de X e de ``[4]`` e então com a leitura da memória realizada, somar/concatenar os valores. Não criando outro espaço em memória para uso, mas fazendo o consumo dos dados já existentes como uma referência em memória, sendo um trabalho de memória mais performático.

&nbsp;

## **TUPLAS**

A sintaxe das tuplas é parecida com a de objetos JavaScript tendo o seu início e fechamento identificado pelo colchetes {}.

&nbsp;

### *DIFERENÇA ENTRE TUPLA E LISTA*

A tupla é armazenada contiguamente na memória, ou seja endereços um após o outro, o que significa que nesse caso temos
acesso direto aos elementos.

```elixir
"É possível acessar diretamente o valor da seguinte forma :"
    Input: 
        x = {1, 2, 3, 4, 5, 6, 7, 8}
        elem(x, 4)    
    
    Output: 5 

"É possível também alterar o valor de um índice específico da tupla :"
    Input:
        x = {1, 2, 3, 4, 5, 6, 7, 8}
        put_elem(x, 4, "abacate")
    
    Output: {1, 2, 3, 4, "abacate", 6, 7, 8}
```

Como os endereços são contiguos, o tamanho da tupla não é dinâmico. Portanto, não podemos simplesmente ir acrescentando novos valores, então no exemplo:  

```elixir
x = {1, 2, 3}
put_elem(x, 8, "abacate")
```  

Um erro será gerado pois esse índice não existe nessa tupla.
> Sempre que for necessário acrescentar valores a uma tupla, deve-se criar uma nova.

&nbsp;

### *IMUTABILIDADE EM TUPLAS*

A lista como exemplificado acima ela sempre vai apontar para o local de memória dos valores originais e então gerar o valor esperado, não criando novos valores em memória.

Ja a tupla trabalha de outra forma, sempre que é realizada uma modificação, é criada uma nova tupla em memória com os valores modificados. Então por um exemplo:

```elixir
x = {1, 2, 3}
put_elem(x, 1, "abacate")
```

Agora existe em memória 2 locais endereçados de tuplas, sendo elas : ``{1, 2, 3}`` e ``{1, "abacate", 3}``

&nbsp;

### *CONTEXTO PARA USO DE TUPLAS*

Normalmente elas são usadas para efetuar um agrupamento de dados que fazem sentido entre si e que normalmente, não vão ter processamentos em cima para modificações extensas ou processo de recursividade/iteração;

&nbsp;

Exemplo de uso das tuplas:

Vamos imaginar que temos um arquivo **tuplas.txt** esse arquivo possui como conteúdo **texto de teste muito testador**.
Agora precisamos recuperar o conteúdo desse arquivo:

```elixir
Input: File.read("tuplas.txt")
Output: {:ok, "texto de teste muito testador"}
```

É possível verificar que ele nos retorna uma tupla com agrupamento de dados que fazem sentido entre si, tendo um *atom* ``:ok``, indicando que a recuperação foi um sucesso
e o conteúdo desse arquivo txt.

&nbsp;

## **TUPLAS VS. LISTAS PARA RETORNOS**

*Tuplas*: Normalmente as utilizadas para retorno de funções, onde é retornado em no 1º indice um *atom* indicando ``:error`` ou ``:ok`` (valores ilustrativos, não sendo regra absoluta) e nos demais parâmetros os valores trabalhados e/ou retornados da função.

*Listas*: Normalmente utilizadas para processar uma grande quantidade informação de forma encadeada e com apontamento para locais de memória já estabelecidos, podendo ser modificadas sem causar um alto consumo de memória.

&nbsp;

## **MAPS**

Maps são estruturas de dados usadas para acesso aos valores de uma tupla pelo modelo *chave => valor (acesso direto)*.

Sintaxe do map:

```elixir
%{a: 1, b: 2, c: 3} -> "os ATOM no map são usados como chave dos valores".

%{"a" => 1, "b" => 2, "c" => 3} -> "Idêntico a sintaxe existente no PHP para arrays"
```

E existe diferença nas formas de criação de um mapa ? Sim, a diferença não é no processamento mas sim como é realizado o acesso.

Exemplo:

```elixir
Input Atom: 
    map_atom = %{a: 1, b: 2}
    map_atom.a
    map_atom[:b]
Output Atom: 
    1
    2

Input String:
    map_string = %{"a": 1, "b": 2}
    map_string["a"]
    map_string["b"]
Output String:
    1
    2
```

> Não é possível no map de string fazer o acesso direto pela notação *ponto*, diferentemente do map de atom.

&nbsp;

Uma forma de se adicionar novos valores ao map antes é utilizando o **Map.put**:

```elixir
Input: 
    x = %{a: 1, b: 2}
    x = Map.put(x, :c, 3)
Output:
    %{a: 1, b: 2, c: 3}
```

No **Map** existem formas de alterar os valores existentes como demonstrado abaixo:

```elixir
1ª forma
    Input:
        x = %{a: 1, b: 2, c: 3}
        Map.put(x, b:, 2.2)
    Output: %{a: 1, b: 2.2, c: 3}

2ª forma
    Input:
        x = %{a: 1, b: 2, c: 3}
        %{x | b : 2.2}
    Output:
        %{a: 1, b: 2.2, c: 3}
```

&nbsp;

É possível existir listas e maps junto ?

Sim, é perfeitamente possível e comum, principalmente com JSON (JavaScript Object Notation) usado em requisições web e retornos de API's
Onde nós teremos uma lista de maps.

Exemplo de uma lista de maps:

```elixir
[
    %{nome: "Gustavo", idade: 23},
    %{nome: "Joao", idade: 30}
]
```

&nbsp;

## **PATTERN MATCHING**

*Match* é o modelo de atribuição utilizado pelo Elixir.  
Diferente de um PHP ou JavaScript da vida, o Elixir não irá simplesmente atribuir o valor a variável, ele vai fazer uma expressão do valor.  
Destaque que o *Pattern Match* existe em todos os modelos de atribuição do Elixir, sejam eles: Listas, Maps, etc.

&nbsp;

Certo, como assim uma expressão ?

Vamos levar em conta o exemplo abaixo:

```elixir
x = 4
```

Em PHP/JavaScript ocorre uma atribuição do valor **4** a variável **X**.

No Elixir vai ocorrer o seguinte: para que essa expressão seja verdadeira, eu devo dizer que o X tem o valor de 4, então ele entrega ao X o valor necessário para dar *Match* com o 4.

Após a atribuição ser feita, caso nós façamos:

```elixir
5 = x
```

Um erro de *Match* ocorrerá, pois o valor de **4** foi dado a **X** para que ele se compare a uma operação verdadeira de sua atribuição.

&nbsp;

### *PATTERN MATCH - LISTAS*

*Match* para as Listas:

```elixir
[a, b, c] = [1, 2, 3]
```

O código está dizendo: Faça um *Match* entre o lado esquerda e o direito, onde obrigatoriamente cada índice da esquerda precisará seguir o valor dos seus índices correlatos a direita.

&nbsp;

Operações como:

```elixir
[a, b, 4] = [1, 2, 3]
```

Não são válidas, pois os valores entre o lado esquerdo e direito deixam de ser verdade entre sim, devido ao ``4`` e ``3``, gerando um erro de *Match*.

&nbsp;

E caso seja necessário efetuar o seguinte Match ``[a] = [1, 2]``, é possível?  

Inicialmente não, porém, nas listas temos os operadores *hd (head)* e *tl(tail)*, com eles é possível fazer o seguinte:

```elixir
Input: 
    [head | tail] = [1, 2, 3]
    head
    tail
Output: 
    1
    [2, 3]
```

Pois assim, é possível recuperar o primeiro índice pelo *hd (head)* e os demais pelo *tl (tail)*.

&nbsp;

### *PATTERN MATCH - MAPS*

*Match* para maps:

```elixir
Input: 
    %{c: valor} = %{a: 1, b: 2, c: 3}
    valor
Output: 
    3
```

Aqui, não é obrigatório que o *Match* ocorra 100%, é possível efetuar essa recuperação de somente um dos valores do lado direito passado, como foi no exemplo acima onde temos o map ``%{a: 1, b: 2, c: 3}`` e foi feita a recuperação somente do valor **c** e o atribuição a variável **valor** pelo código: ``%{c: valor}``

> Bem parecido com o esquema de ***Destructuring Assignment*** ou ***Desestruturação de Assinatura*** existente no JavaScript.

&nbsp;

Observações sobre *Match* no map:  

1. Não existe uma ordem para o *Match* aqui, podendo ser feito em qualquer ordem desejada, exemplo:

    ```elixir
    %{d: valor1, z: valor2, a: valor3} = %{a: 1, b: 2, d: 10, z: 0, t: 12}
    ```

2. Não é possível efetuar esse processo para chaves não existentes como:

    ```elixir
    %{x: valor1} = %{a: 1, b: 2, c: 3}
    ```

    Tal ação estoura erro no *Match*.

&nbsp;

### *PATTERN MATCH - TUPLAS*

*Match* para tuplas:`

```elixir
{head, result} = File.read("teste.txt")
```

Aqui foi utilizado um exemplo diferente, na explicação das tuplas foi dado um exemplo referente ao ``File.read``, podemos utilizar ele para explicar como o Match é interessante para a aplicação.  
Nesse caso, sabemos que ele nos retorno em primeiro índice ``:ok`` ou ``:error``, usando isso ao nosso favor pelo ``*head*`` podemos validar o valor do mesmo para adicionar lógica a aplicação.

&nbsp;

Para demais efeitos, o *Match* de **tuplas** vai seguir as mesmas regras das **listas**

&nbsp;

### *PATTERN MATCH - PIN*

*Match* com pin:

```elixir
x = 5  -> "Nesse caso a reatribuição de X é possível".
^x = 5 -> "Nesse caso, estou 'pinando' o valor de X, ou seja, ele não poderá ser reatribuido novamente, gerando erro de Match" 
```

No caso do pin, é como se fosse falado para a linguagem: o valor dessa variável não pode ter *Match* ou ser modificado pela aplicação.

&nbsp;

### *PATTERN MATCH - USO PRÁTICO*

Pattern Match é comumente usado junto de funções anônimas, exemplo:

```elixir
Input:
    multiply = fn a, b -> a * b end
    multiply.(2, 3)

Output:
    6
```

O que acontece aqui ?  
``fn`` é a chamada de função, como uma abreviação de ``function``;  
``a, b`` são os parâmetros dessa função;  
``->`` é como se fosse o ``=>`` de funções anônimas com retorno direto de linguagens como PHP / JavaScript;  
``a * b`` operação realizada pela função;  
``end`` indicativo de que a função finalizou o seu processamento;

&nbsp;

Outro exemplo mais complexo das funções anônimas é:

```elixir
Input:
    read_file = fn 
        {:ok, result} -> "Success #{result}"
        {:error, reason} -> "Error #{reason}" 
        end

    read_file.({:ok, "abacaxi"})
    read_file.({:error, "eita rapaz"})

Output:
    "Success abacaxi"
    "Error eita rapaz"
```

O que ocorre nesse código?  
Após o FN com a quebra de linha é possível pelo Pattern Match das Tuplas, recuperar da Tupla que veio na ativação da função os valores ``:ok`` e ``:error`` onde pela construção da função foi possível identificar o valor recebido e efetuar o seu devido retorno sem o uso de cláusulas ``if - else``.
