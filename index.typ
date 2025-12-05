#include "01 - Teoria della Computabilità/chapter.typ"

= Modulo 2: Modelli computazionali
== 1. Processi computazionali iterativi e ricorsivi
Durante l'esecuzione di un programma l'elaboratore esegue calcoli in diversi modi a seconda dell'algoritmo scritto. Tra i metodi di iterazione più comuni si possono distinguere due tipi principali: l'iterazione e la ricorsione.

Eliminando i costrutti sintattici e semantici specifici dei linguaggi di programmazione, questi due approcci hanno differenze sostanziali comuni attraverso qualsiasi linguaggio di programmazione.


=== 1.1 Iterazione
- Esiste una variabile di accumulo inizializzata al valore "identitá" dell'operazione, questa variabile viene aggiornata ad ogni iterazione.
- Viene definita un'espressione booleana che stabilisce quando terminare l'iterazione. Questa espressione dipende sempre da una variabile di controllo che viene aggiornata ad ogni iterazione (altrimenti si avrebbe un ciclo infinito).
- Durante ogni iterazione queste variabili vengono aggiornate con i nuovi valori: il vecchio stato viene sovrascritto con il nuovo e il programma si avvicina passo passo alla soluzione: la computazione è in avanti.

=== 1.2 Ricorsione
- Esiste una funzione divisa fondamentalmente in due casi: il caso base che restituisce la soluzione per uno specifico valore di input e il caso ricorsivo che richiama la funzione stessa con un valore di input diverso.
- Per trovare la soluzione il programma chiama la funzione che crea il proprio record di attivazione, la funzione poi chiama sé stessa con un nuovo valore di input, creando un nuovo record di attivazione, e così via fino a raggiungere il caso base (unfolding).
- Una volta creati tutti i record di attivazione, la soluzione viene "sbrogliata" partendo dal caso base e utilizzando il risultato per calcolare ogni caso precedente (folding) fino ad arrivare alla soluzione: la computazione è all'indietro.

#figure(
  image("media/IterazioneVsRicorsione.svg"),
  caption: [Modello di esecuzione iterativo (sinistra) e ricorsivo (destra).]
)

#figure(
  image("media/FattorialeRicorsivo.svg"),
  caption: [Modello di esecuzione iterativa.]
)

#figure(
  image("media/FattorialeIterativo.svg"),
  caption: [Modello di esecuzione iterativa.]
)

=== Esecuzione tail recursive
In questo particolare esempio di esecuzione ricorsiva, la chiamata ricorsiva è l'ultima operazione eseguita (tail) dalla funzione, inoltre possiamo notare la presenza di un accumulatore e una variabile di controllo, come nel caso iterativo. Inoltre si può notare che il risultato è computato in avanti, dato che i valori della chiamata precedente non sono necessari alla chiamata successiva è possibile evitare il processo di unfolding e folding, sovrascrivendo il record di attivazione della funzione ad ogni chiamata ricorsiva, ottenendo cosi un modello di esecuzione iterativo con una sintassi ricorsiva.

#figure(
  image("media/FattorialeTailRecursive.svg"),
  caption: [Modello di esecuzione tail recursive.]
)

#figure(
  image("media/TailRecursiveOpt.svg"),
  caption: [Confronto tra i modelli di esecuzione iterativo, ricorsivo e tail recursive.]
)

== 2. Programmazione funzionale
La programmazione funzionale è un paradigma di programmazione come quello funzionale o ad oggetti. I linguaggi di questo paradigma offrono differenze sostanziali rispetto a linguaggi più popolari imperativi o orientati agli oggetti, tra le principali ci sono:
- I valori sono immutabili: una volta assegnato un valore ad una variabile, essa non può essere alterata, per modificare il valore è necessario creare una nuova variabile.
- Dato che i valori sono immutabili, il modello di esecuzione non porta a side-effects, perciò ogni cosa è un espressione e non esiste la differenza tra istruzioni ed espressioni.
- Le strutture dati, analogamente ai valori, sono immutabili. Il caso di utilizzo più comune del paradigma funzionale è la creazione di una nuova struttura dati a partire da una esistente, sintetizzando ogni oggetto della collezione di partenza un elemento della nuova collezione.
- Le funzioni sono entità di prima classe: in sintesi devono essere trattate come un qualsiasi altro valore, ciò significa che devono avere un tipo, possono essere assegnate a variabili, passate come argomenti ad altre funzioni e restituite come risultato di altre funzioni. Inoltre devono anche poter essere eventualmente eseguite e restituire il risultato della loro computazione.
