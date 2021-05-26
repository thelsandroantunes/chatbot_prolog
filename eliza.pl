:- ensure_loaded(readatom).
:- dynamic list_of_excuses/1.

list_of_excuses(['I see.', 'Very interesting.', 'Tell me more.', 'Fascinating.']).

eliza :-
    write('Eliza > '),
    write('Hello! My name is eliza.'), nl,
    eliza_loop.

eliza_loop :-
    write(' > '),
    read_atomics(Input),
    write(Input), nl,
    respond(Input).

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
respond(Input) :-
    member(Exit, Input),
    member(Exit, [ quit, exit, leave ]),
    write('Eliza > Goodbye'), nl.
respond([ _ ]) :-
    retract(list_of_excuses([ Next | Rest ])),
    append(Rest,[ Next ],NewExcuseList),
    asserta(list_of_excuses(NewExcuseList)),
    write('Eliza > '),
    write(Next),nl,
    eliza_loop.

respond(Input) :-
    member(Food, Input),
    member(Food,[hamburguer, pizza, sweet, hot-dog, hotdog, fried chicken, sope]),
    write('Eliza > '),
    write('You just said '), write(Food), write('? I have never eaten '), write(Food), write('. Is it tasty?')
    eliza_loop