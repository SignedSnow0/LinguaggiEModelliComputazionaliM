= Modulo 1: linguaggi
== 1. Teoria della computabilità
Nel primo capitolo vogliamo rispondere ad alcune domandi fondamentali nella teoria della computazione: in particolare vogliamo sapere se un calcoratore, a prescindere dalla sue risorse e dal tempo impiegato, possa risolvere qualsiasi problema o meno.
Iniziamo a studiare il problema definendo alcuni termini fondamentali.
- Un algoritmo è una sequenza finita di mosse che portano alla soluzione di una classe di problemi.
- Una codifica è una descrizione di un algoritmo in un insieme ordinato di frasi che indicano le mosse da eseguire.
- Un programma è un testo scritto in accordo con una sintassi e semantica di un linguaggio di programmazione.
Inoltre per risolvere un problema è necessaria una macchina in grado di eseguire l'algoritmo partendo da dei dati di input per portare eventualmente alla soluzione del problema: questa macchina è chiamata automa esecutore e verrà studiata in dettaglio per sapere quali problemi può risolvere.
=== 1.1 Automa esecutore
In generale un automa esecutore è una macchina astratta in grado di interpretare la codifica dell'algoritmo e di eseguirlo su un insieme di dati di input. Esistono diversi tipi di automi esecutori, tra i più importanti ci sono:
- Macchina combinatoria
- Automa a stati finiti
- Macchina di Turing.
==== 1.1.1 Macchina combinatoria
Una macchina base è formalmente definita dalla tripla
$ chevron.l I,O, "mfn" chevron.r $
dove:
- $I$ è l'insieme finito dei simboli di input
- $O$ è l'insieme finito dei simboli di output
- $"mfn": I arrow.r O$ è la funzione macchina
Un esempio di una macchina combinatoria è un adder a 1 bit, con $I={{0,1} times {0,1}}$, $O={0,1}$ e $"mfn"=I_1 xor I_2$.
Le soluzioni di questa macchina sono ottenute computando la sua tabella della verità, ma comporta forti limatazioni in quanto sprovvista di stato.
==== 1.1.2 Automa a stati finiti
Un automa a stati finiti è formalmente definito dalla quintupla
$ chevron.l I, O, S, "mfn", "sfn" chevron.r $ 
dove:
- $I$ è l'insieme finito dei simboli di input
- $O$ è l'insieme finito dei simboli di output
- $S$ è l'insieme finito degli stati
- $"mfn": S times I arrow.r O$ è la funzione macchina
- $"sfn": S times I arrow.r S$ è la funzione di stato
Nonostante questo modello sia più potente alla macchina combinatoria, ha comunque una forte limitazione: la memoria della macchina è limitata in quanto collegata al numero di (finito) di stati della macchina stessa.
==== 1.1.3 Macchina di Turing
Una macchina di Turing è definita dalla quintupla
$ chevron.l A, S, "mfn", "sfn", "dfn" chevron.r $ 
dove:
- $A$ è l'insieme finito dei simboli di ingresso e uscita
- $S$ è l'insieme finito degli stati della macchina, che include uno stato speciale chiamato HALT
- $"mfn": S times A arrow.r A$ è la funzione macchina
- $"sfn": S times A arrow.r S$ è la funzione di stato
- $"dfn": S times A arrow.r { "Left", "Right", "None" }$ è la funzione di direzione
Nella macchina di Turing i simboli utilizzati per la rappresentazione di input, output e stato sono memorizzati su un nastro estendibile a piacimento, ciò permette alla macchina di superare la limitazione della macchina a stati finiti. Nel ciclo di esecuzione classico la macchina:
1. Legge il simbolo sotto la testina di lettura/scrittura
2. Scrive il simbolo specificato da $"mfn"$
3. Transita in un nuovo stato indicato da $"sfn"$
4. Muove la testina di lettura/scrittura nella direzione specificata da $"dfn"$
5. Eventualmente la macchina raggiungerà lo stato HALT, che indica il termine della computazione.

Esempio:\
Cerchiamo di realizzare una macchina di Turing che riconosce parole palindrome:
La parola è composta da bit con valore 0 o 1 e deve essere terminata da un carattere speciale "X", se alla fine dell'esecuzione il nastro contiene il simbolo "Y" la frase è palindroma, se contiene il simbolo "N" la frase non lo è. Gli insiemi sono definiti come segue:
- $A={0,1,"X","Y","N"}$
- $S={"S0 (stato iniziale)", "S1", "S2", "S3", "S4", "S5", "HALT"}$

#table(
  align: center,
  columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
  table.header([*mfn*], [S0], [S1], [S2], [S3], [S4], [S5]),
  [0], [X], [0], [0], [X], [N], [0],
  [1], [X], [1], [1], [N], [X], [1],
  [X], [Y], [X], [X], [Y], [Y], [X]
)

#table(
  align: center,
  columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
  table.header([*sfn*], [S0], [S1], [S2], [S3], [S4], [S5]),
  [0], [S1], [S1], [S2], [S5], [HALT], [S5],
  [1], [S2], [S1], [S2], [HALT], [S5], [S5],
  [X], [HALT], [S3], [S4], [HALT], [HALT], [S0]
)

#table(
  align: center,
  columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
  table.header([*dfn*], [S0], [S1], [S2], [S3], [S4], [S5]),
  [0], [R], [R], [R], [L], [-], [L],
  [1], [R], [R], [R], [-], [L], [L],
  [X], [-], [L], [L], [-], [-], [R]
)

il procedimento della macchina è illustrato nella seguente figura:
#figure(
  image("../media/EsempioTuring.svg"),
  caption: [Esecuzione di una macchina di Turing che riconosce parole palindrome.]
)

=== 1.2: Capacità computazionale della macchina di Turing
Iniziamo enunciando una tesi fondamentale nello studio della computabilità: la tesi di Church-Turing.
Non esiste alcun formalismo capace di risolvere una classe di problemi più ampia di quella risolta dalla macchina di Turing.
Ciò implica che, finchè la tesi è vera, non potrà esistere alcun calcolatore in grado di risolvere problemi che non sono risolvibili con la macchina di Turing. Sorge allora la seguente domanda: esistono problemi che non sono risolvibili dalla macchina di Turing?
Per rispondere a questa domanda iniziamo definendo una particolare macchina di Turing.
==== 1.2.1 Macchina di Turing universale
La macchina di Turing come precedentemente definita è in grado di computare un solo algoritmo, codificato nelle sue tre funzioni mfn, sfn e dfn. Possiamo però definire una macchina di Turing particolare che come prima operazione va a leggere queste tre funzioni dal nastro stesso per poi eseguire l'algoritmo codificato su un secondo insieme di dati di input. Questa particolare macchina è detta macchina di Turing universale. Per quanto possa sembrare astratta, questo tipo di macchina non fa altro che prendere una descrizione di un problema in un'opportuna rappresentazione e produrre un output in base ai dati di ingresso: si comporta esattamente come un compilatore o un interprete.
==== 1.2.2 Problemi non computabili
Per studiare l'esistenza di problemi non computabili definiamo la funzione caratteristica di un problema $P$ come
$f_P:X arrow.r Y$ la funzione che associa ad ogni elemento $x in X$ la risposta corretta del problema $y in Y$. Allora un problema irrisolvibile non è altro che una funzione caratteristica non computabile, e un problema è computabile se esiste una macchina di Turing che per ogni $x in X$ produce in output $f_P(x)$ dopo un numero finito di passaggi.
Da questa definizione possiamo subito trovare esempi triviali di problemi non computabili, come per esempio ogni insieme di stati che portano la macchina in un ciclo infinito. Un esempio più interessante però è l'halting problem.
==== 1.2.3 Halting problem
L'halting problem cerca di rispondere ad una semplice domanda:
Data una macchina di Turing $T$ con ingresso $X$, stabilire se si fermerà o meno.
Questo problema non è in genere computabile.
Dimostrazione:
Definiamo $M$ l'insieme di tutte le macchine di Turing e $X$ l'insieme di tutti i possibili ingressi, e indichiamo con $perp$ lo stato di una macchina di Turing che non si ferma. Definiamo allora la funzione caratteristica del problema 
$ f_"HALT"(m,x)=cases(1" se "m" con ingresso "x" si ferma",0" se "m" con ingresso "x" non si ferma") $
Se $f_"HALT"$ è computabile allora esiste una macchina di Turing $T_"HALT"$ in grado di computarla. Costruiamo allora una nuova funzione
$ g(m)=cases(1" se "f_"HALT"(m,m)=0,0" se "f_"HALT"(m,m)=1)=cases(1" se la macchina "m" non si ferma",perp"se la macchina "m" si ferma") $ se ora cerchiamo la soluzione di $g(n_g)$ cioè la macchina di Turing che computa lo stesso problema, otteniamo che:
$ g(n_g)=cases(1" se la macchina non si ferma",perp" se la macchina non si ferma") $ che è un assurdo. Abbiamo quindi trovato un problema indecidibile, cioè non computabile da una macchina di Turing.
=== 1.3 Generabilità e decidibilità di un insieme
Ci interesserà sapere in futuro se un valore appartiene o meno ad un insieme, per fare ciò prima di tutto l'insieme deve essere al massimo di dimensione $aleph_0$, cioè enumerabile. Ma oltre a ciò perchè una macchina possa generare l'insieme, la funzione di enumerazione $f:NN arrow.r X$ deve essere computabile da una macchina di Turing, allora l'insieme è ricorsivamente enumerabile o semi-decidibile.
Per poter decidere se un elemento appartiene o meno ad un insieme, non basta però poter generare l'insieme, ma bisogna poter generare anche tutti gli elementi con non ne appartengono, ottenendo così la sua funzione caratteristica $ f=cases(1" se "x in X,0" se "x in.not X arrow.l.r.double x in X^complement) $
l'insieme è allora ricorsivo o decidibile.
Questo discorso ci sarà utile nello studio dei linguaggi e dei compilatori: programmi che devono essere in grado di decidere se un insieme finito di simboli sia valido o meno, e in maniera più importante, devono farlo in un tempo finito.
= 2. Linguaggi e grammatiche
Per studiare i linguaggi da un punto di vista formale dobbiamo iniziare introducendo alcune definizioni:
- Un alfabeto $A$ è un insieme finito e non vuoto di simboli atomici: $A={a, b, ...}$
- Una stringa è composta dal prodotto cartesiano dell'alfabeto con se stesso $n$ volte: $s in A^n$
- La launghezza di una stringa $s$ è il numero di simboli che la compongono
- Esiste una particolare stringa chiamata stringa vuota, indicata con $epsilon$, che ha lunghezza zero
- Un linguaggio $L$ è un insieme di stringhe costruite a partire dall'alfabeto
- Una frase è una stringa appartenente ad un linguaggio
- La cardinalità di un linguaggio è il numero di stringhe che può produrre.
- La chiusura di un alfabeto è tutte le frasi che può produrre $ A^*=union.big _"n=0"^oo A^n $
- La chiusura positiva di un alfabeto è tutte le frasi che può produrre ad eccezione della stringa vuota $ A^+=A^*backslash {epsilon} $
=== 2.1 Grammatiche formali
Le grammatiche sono strumenti utilizzati per definire i linguaggi permessi, senda doverne elencare ogni frase lecita. Formalmente è definito dalla quadrupla
$ chevron.l "VT", "VN", P, S chevron.r $
dove:
- $"VT"$ è l'insieme finito dei simboli terminali, cioè i simboli dell'alfabeto
- $"VN"$ è l'insieme finito dei simboli non terminali, cioè i simboli utilizzati per la definizione della grammatica
- $P$ è l'insieme finito delle produzioni, cioè le regole di riscrittura della grammatica: $P: alpha arrow.r beta$ dove $alpha,beta$ sono stringhe composte da simboli terminali e non terminali
- $S in "VN"$ è il simbolo iniziale, cioè il simbolo da cui inizia la generazione delle frasi detto anche scopo.
Allora ogni composizione che inizia da $S$ e viene riscritto applicando le regole di produzione $P$ fino ad ottenere una string composta da soli simboli terminali $"VT"$ appartiene al linguaggio generato dalla grammatica e si chiama frase.\
Dati due simboli $alpha,beta$ si dice che $beta$ deriva direttamente da $alpha$ se
- $alpha=eta A delta$ e $beta=eta gamma delta$
- esiste una produzione $A arrow.r gamma$
in particolare si dice sequenza di derivazione le sequenza di produzioni che portano alla forma di frase $sigma$ partendo dallo scopo iniziale, e si scrive con $S arrow.r.double^* sigma$\
Allora possiamo definire un linguaggio come l'insieme di frasi terminali derivabili dallo scopo iniziale:
$ L= {s in "VT"^* | S arrow.r.double^* s} $
=== 2.2 Classificazione di Chomsky
La classificazione di Chomsky indica la capacità espressiva di un linguaggio in base alle sue restrizioni, e come vedremo successivamente, ogni classificazione rende un linguaggio più o meno complicato da riconoscere.
==== 2.2.1 Linguaggio di tipo 0
Un linguaggio di tipo 0 semplicemente non ha restrizioni sulle produzioni, in particolare alcune produzioni possono usare la stringa vuota $epsilon$ e quindi possono accorciare la frase.
==== 2.2.2 Linguaggio di tipo 1 (Dipendente dal contesto)
I linguaggi di tipo 1 sono vincolati da produzioni della forma
$ beta A delta arrow.r beta alpha delta $
con $alpha eq.not epsilon$, quindi $A$ può essere riscritta come $alpha$ solo nel contesto $beta A delta$. Inoltre le riscritture non accorciano mai la frase ($alpha eq.not epsilon$), perciò $|beta| >= |alpha|$.
==== 2.2.3 Linguaggio di tipo 2 (Libero dal contesto)
I linguaggi di tipo 2 sono analoghi al tipo 1, ma senza contesto. Le restrizioni sono quindi della forma
$ A arrow.r alpha $
in questo caso però $alpha$ può essere la stringa vuota. In particolare se $alpha=u$ oppure $alpha=u B v$ la grammatica si dice lineare.
==== 2.2.4 Linguaggio di tipo 3 (Regolare)
Una grammatica regolare è definita da produzioni lineari a destra o a sinistra
$ A arrow.r sigma quad A arrow.r sigma B ("lineare destra") $
$ A arrow.r sigma quad A arrow.r B sigma ("lineare sinistra") $
un linguaggio è regolare se contiene tutte regole lineari destra o tutte regole lineari sinistra, ma non un mix.
=== Linguaggi e riconoscitori
La classificazione di Chomsky è utile nello studio dei linguaggi e in particolare nella realizzazione di un riconoscitore, in quanto ogni tipo di linguaggio corrisponde ad un particolare tipo di automa riconosicitore più o meno complesso:
#table(
  align: center,
  columns: (1fr, 1fr),
  table.header([*Tipo di linguaggio*], [*Automa riconoscitore*]),
  [Tipo 0], [*Se il linguaggio è riconoscibile*, allora è necessaria una macchina di Turing],
  [Tipo 1: Context dependent], [Macchina di Turing],
  [Tipo 2: Context free], [Push down Automaton, cioè un automa a stati finiti con uno stack],
  [Tipo 3: Regolare], [Automa a stati finiti]
)
==== Linguaggi regolari
Per iniziare lo studio dei riconoscitori iniziamo con i linguaggi più semplici: i linguaggi regolari. Come precendententemente detto un linguaggio regolare è un linguaggio del tipo
#table(
  align: center,
  columns: (1fr, 1fr, 1fr, 1fr),
  stroke: none,
  [], [$ A & arrow.r sigma \ A & arrow.r sigma B $], [$ A & arrow.r sigma \ A & arrow.r B sigma $], []
)
Inoltre ogni linguaggio regolare può essere ridotto a in una forma streattamente lineare, cioè dove ogni produzione aggiunge un singolo carattere terminale:
#table(
  align: center,
  columns: (1fr, 1fr, 1fr, 1fr),
  stroke: none,
  [],
  [$
    A & arrow.r s \
    A & arrow.r s B
  $],
  [$
    A & arrow.r s \
    A & arrow.r B s
  $],
  [],
)
Esempio:
Le espressioni matematiche composte da somme e sottrazioni sono esprimibili dalla seguente grammatica:
$ "VT"={"num",+,-} $
$ "VN"={S} $  
$ S &arrow.r "num" \ S &arrow.r "num" + S \ S &arrow.r "num" - S \ $
introducendo una nuova variabile non terminale $A$ si ha:
$ "VT"={"num",+,-} $
$ "VN"={S,A} $
$ S &arrow.r "num" \ S &arrow.r "num" A \ A &arrow.r + S \ A &arrow.r - S $
==== Eliminazione delle $epsilon$-Rules
La classificazione di Chomsky esprime una relazione gerarchica tra i vari livelli di linguaggio, andando dal più generale (tipo 0) al più specifico (tipo 3). Da un primo punto di vista, dato che il lunguaggio di tipo 1 non ammette stringhe vuote, e i linguaggi di tipo 2 e 3 le ammettono, sembrerebbe che questo ordine gerarchico sia violato: invece grazie ad un utile teorema abbiamo che:\
Le produzioni di grammatiche di tipo 2 possono sempre essere riscritte in modo da evitare la stringa vuota, al più possono contenere la regola $S arrow.r epsilon$ che indica un linguaggio vuoto.
Per creare la grammatica equivalente senza $epsilon$-rules, iniziamo definendo i seguenti insiemi:
- $Y_epsilon$: l'insieme dei metasimboli $A_k$ da cui si può ricavare $epsilon$
- $N_epsilon$: l'insieme dei metasimboli $B_k$ da cui non si può ricavare $epsilon$
- Se $L$ contiene una produzione della forma $X arrow.r C_1...C_r, r >= 1$, allora $X'$ conterrà produzioni $alpha_1...alpha_r$ dove: 
  $ alpha_k=C_k &"se" C_k in N_epsilon union "VT" \ alpha_k=C_k | epsilon &"se" C_k in Y_epsilon $
Esempio:
Sia L la grammatica data dalle seguenti regole:
$ S &arrow.r A B | B \ A &arrow.r a A | epsilon \ B &arrow.r b B | c $
allora si ha $Y_epsilon={A}$ e $N_epsilon={S,B}$. Le regole $S,B$ rimangono invariate, mentre nella regola $A=a A | epsilon$, la $A$ a destra della produzione va sostituita con $(A | epsilon)$, allora riscrivendo la regola e raccogliendo si ottiene $A arrow.r a (A | epsilon)=a A | a$ ottenendo la grammatica $L'$:
$ S &arrow.r A B | B \ A &arrow.r a A | a \ B &arrow.r b B | c $ senza $epsilon$-rules.\
Esiste infine un breve teorema che afferma che:\
Dato un linguaggio $L$ di un qualsiasi tipo (0, 1, 2, 3):
$ L union {epsilon}, quad L without {epsilon} $
sono dello stesso tipo.
==== Regole di distrizione fra i linguaggi
Lo stesso linguaggio potrebbe essere generato da grammatiche differenti e soprattutto queste grammatiche potrebbero appartenere a classificazioni diverse. Vogliamo allora avere modi per sapere se un linguaggio è semplificabile o meno.\
Regola 1:\
Un linguaggio di tipo 1 ammette produzioni della forma
$ A B arrow.r B A $
che non sono permessi in linguaggi di tipo 2.\
Regola 2:\
Una grammatica di tipo 2 ammette produzioni di self embedding della forma
$ A arrow.r.double^*alpha A beta quad alpha,beta in V^+ $
se il linguaggio non ammette regole di self embedding allora è riducibile al tipo 3.
=== Backus-Naur Form
La grammatica Backus-Naur Form (BNF) è una notazione compatta per la rappresentazione delle grammatiche di tipo 2 e 3.\
In questa notazione le produzioni sono scritte come $alpha := beta$, i simboli non terminali sono scritti come \<A\>. Per esempio la somma si rappresenta come:\
\<sum\>:= \<num\> | \<num\> + \<sum\> | \<num\> - \<sum\> \
\<num\>:= (0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9)\<num\>\
Inoltre esiste una forma estesa della BNF chiamata EBNF (Extended Backus-Naur Form) che introduce elementi di ripetizione come:
- $[alpha]$: indica che $alpha$ è opzionale
- ${alpha}^n$: indica che $alpha$ può ripetersi da zero a $n$ volte
- ${alpha}$: indica che $alpha$ può ripetersi zero o più volte
\<sum\>:= \<num\> { (+ | -) \<num\> }\
\<num\>:= { digit }\
\<digit\>:=0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
=== Pumping Lemma
Il pumping lemma dà una condizione necessaria ma non sufficente perchèun linguaggio sia di tipo 2 o 3.\
Il lemma punta a trovare stringhe di lunghezza infinita andando a cercare segmenti periodici all'interno della frase.\
Allora se un linguaggio ha una regola che può essere "pompata" un numero infinito di volte si può andare ad escludere un'intera categoria di linguaggi.\
Ad esempio un linguaggio
$ A arrow.r A a = A={a^n} $
non è sicuramente di tipo 2 grazie al pumping lemma.

=== Forme normali
I linguaggi di tipo 2 possono essere riscritti in maniera da seguire queste proprietà:
1. Ogni simbolo terminale o non compare in almeno una produzione.
2. Non esistono produzioni della forma $A arrow.r B$ con $A,B in "VN"$, cioè produzioni che cambiano il nome di un simbolo non terminale.
3. Se il linguaggio contiene la stringa vuota, l'unica produzione che la genera è $S arrow.r epsilon$ e $S$ non compare in nessun'altra produzione.
Inoltre esistono due forme normali particolari:
==== Forma normale di Chomsky
Una grammatica è in forma normale di Chomsky se ogni produzione è della forma:
$ A arrow.r B C | a $
==== Forma normale di Greibach
Una grammatica è in forma normale di Greibach se ogni produzione è della forma:
$ A arrow.r a alpha $
queste regole sono utili, specialmente la forma di Greibach, per la costruzione di riconoscitori di linguaggi efficienti.
=== Ricorsione sinistra
Alcuni linguaggi possono avere regole di produzioni con forme di ricorsione sinistra diretta
$ A arrow.r A a | p $
o indiretta
$ A &arrow.r B a \ B &arrow.r C b \ C &arrow.r A c | p $
queste forme di ricorsione possono portare a problemi nella scrittura di riconoscitori, in quanto un algoritmo basato sulla ricorsione avrebbe come primo passo quello ricorsivo, portando a stack overflow.
#image("../media/LeftRecursion.svg")
Da come abbiamo visto prima è possibile eliminare la ricorsione sinistra portando il linguaggio in forma normale di Greibach, ma nonostante l'apparente vantaggio, non è desiderabile in quanto porterebbe a problemi futuri.\
Prendiamo come esempio la grammatica che descrive le espressioni:
$ E arrow.r E + "num" | E - "num" | "num" $
In questo caso la ricorsione sinistra è evidente, e per eliminarla potremmo portare la grammatica in forma di Greibach:
$ E arrow.r "num" E' \ E' arrow.r + "num" E' | - "num" E' | epsilon $
Prendiamo però in considerazione la frase "13-4-5", queste due grammatiche portano a due ordini di dericazione differenti, sinsteizzati nei seguenti alberi:
#figure(
  image("../media/ASTLeftRecursive.svg"),
  caption: [Albero di derivazione della frase "13-4-5" con grammatica ricorsiva sinistra.]
)
#figure(
  image("../media/ASTRightRecursive.svg"),
  caption: [Albero di derivazione della frase "13-4-5" con grammatica ricorsiva destra.]
)
Questi due alberi, se valutati dal basso verso l'alto portano a: $(13-4)-5=9-5=4$ e $13-(4-5)=13-(-1)=14$, perciò, dato che le operazioni aritmentiche sono associative a sinistra, la grammatia ricorsiva a destra, pur essendo più semplice non riesce ad esprimere i corretti vincoli di costruzione della frase.\
=== Espressioni regolari
Le espressioni regolari sono un altro formalismo per descrivere linguaggi basato su tre regole:
1. $epsilon$ è un'espressione regolare
2. Dato un alfabeto $A$, ogni elemento $a in A$ è un espressione regolare
3. Se $X,Y$ sono espressioni regolari, lo sono anche $X+Y, X dot Y, X^*$
dove le operazioni sono definite come:
$ 
X+Y&={x|x in X or x in Y}\ 
X dot Y &={x|x=a b, a in X and b in Y}\ 
X^*&=union.big_(n=0)^oo X^n 
$
Come è possibile immaginare le espressioni regolari sono importanti grazie al seguente teorema:\
I linguaggi descritti da espressioni regolari coincidono con i linguaggi generati da grammatiche regolari.\
Prendiamo per esempio il seguente linguaggio:
$ S arrow.r a | a + S | a - S $
abbiamo tre simboli dell'alfabeto: $a, +, -$:
1. Abbiamo allora tre regole $S=a$, $S = a+S$, $S = a-S$
2. Raccogliamo le seconde due: $S=(a+ union a-)S$ e riaggiungendo la prima abbiamo $S=(a+ union a-)S + a$
3.Raccogliamo la regola in una chiusura: $S=(a+ union a-)^* a$
In altre sintassi la regola potrebbe essere scritta diversamente: $S=(a+|a-)^*a$
