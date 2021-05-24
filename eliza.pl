:- ensure_loaded(readatom).
:- dynamic list_of_excuses/1.

list_of_excuses(['I see.', 'Very interesting.', 'Tell me more.', 'Fascinating.']).

eliza :-
    write('Eliza > '),
    write('Hello! My name is eliza.'), nl,
    eliza_loop.

eliza_loop :-
    write(' > '),
    read_atomics(Words),
    (  ( Words == [quit] ; Words = [quit, '.'])
    -> true
    ; (  Words = [] 
      -> fail
      ;  respond(Words), 
         fail
      )
    ),
    !.

respond([my,name,is,Name | _ ]) :-
    write('Eliza > '),
    write('Hello, '), write(Name), write('! Pleased to meet you.'), nl,
    eliza_loop.

respond([my,Thing,is,called,Name | _ ]) :-
    write('Eliza > '),
    write(Name), write(' is a nice name for a '), write(Thing), write('.'), nl,
    eliza_loop.
respond(Input) :-
    member(Animal,Input),
    member(Animal,[ cat, dog, fish, hamster, gerbil, snake, tortoise ]),
    write('Eliza > '),
    write('You just mentioned your '), write(Animal), write('. Tell me more about your '), write(Animal), nl,
    eliza_loop.

respond([ _ ]) :-
    retract(list_of_excuses([ Next | Rest ])),
    append(Rest,[ Next ],NewExcuseList),
    asserta(list_of_excuses(NewExcuseList)),
    write('Eliza > '),
    write(Next),nl,
    eliza_loop.