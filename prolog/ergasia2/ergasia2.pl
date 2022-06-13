precede_list([],[]).
precede_list([],[H|T]).

precede_list([H1|T1], [H2|T2]):-
H1=H2,
precede_list(T1,T2).