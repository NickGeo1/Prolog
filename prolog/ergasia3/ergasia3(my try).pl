:- dynamic human_l/6.




solution:-							/*(D1,T1,P1,Pc1,B1,D2,T2,P2,Pc2,B2,D3,T3,P3,Pc3,B3,D4,T4,P4,Pc4,B4,D5,T5,P5,Pc5,B5):-*/
	human(loc(1), dep(D1), tab(T1), phone(P1), pc(Pc1), bev(B1)), 
	human(loc(2), dep(D2), tab(T2), phone(P2), pc(Pc2), bev(B2)),
	human(loc(3), dep(D3), tab(T3), phone(P3), pc(Pc3), bev(B3)),		
	human(loc(4), dep(D4), tab(T4), phone(P4), pc(Pc4), bev(B4)),
	human(loc(5), dep(D5), tab(T5), phone(P5), pc(Pc5), bev(B5)). 	
		
/*human(loc(_), dep(informatics), tab(red), phone(_), pc(_), bev(_)).	

	human(loc(_), dep(organization_and_administration), tab(_), phone(_), pc(macbook_pro), bev(_)).
	human(loc(1), dep(international_relations), tab(_), phone(_), pc(_), bev(_)).		
	human(loc(_), dep(iconomics), tab(_), phone(_), pc(_), bev(tea)).				
	human(loc(_), dep(supplies), tab(_), phone(ericsson), pc(_), bev(_)).					

	human(loc(_), dep(_), tab(_), phone(android), pc(_), bev(orange_juice)).				
	human(loc(_), dep(_), tab(_), phone(i_phone), pc(macbook_air), bev()).		
	human(loc(_), dep(_), tab(yellow), phone(blackberry), pc(_), bev(_)).			
	human(loc(3), dep(_), tab(_), phone(_), pc(_), bev(milk)).*/					






human(loc(N), dep(_), tab(green), phone(_), pc(_), bev(coffe)).	%%3.   O εργαζόμενος στο πράσινο γραφείο πίνει καφέ.
	%member(N,[1,2,3,4,5]). 	
	
human(loc(N), dep(informatics), tab(red), phone(_), pc(_), bev(_)).	%%1.   Ο εργαζόμενος από το τμήμα πληροφορικής έχει το κόκκινο γραφείο.

human(loc(N), dep(organization_and_administration), tab(_), phone(_), pc(macbook_pro), bev(_)).%%2.   Ο εργαζόμενος από το τμήμα οργάνωσης και διοίκησης έχει macbook pro.
human(loc(1), dep(international_relations), tab(_), phone(_), pc(_), bev(_)).		%%9.   Ο εργαζόμενος από το τμήμα διεθνών σχέσεων έχει το πρώτο γραφείο (από αριστερά).	
human(loc(N), dep(iconomics), tab(_), phone(_), pc(_), bev(tea)).				%%4.  Ο εργαζόμενος από το οικονομικό τμήμα πίνει τσάι.
human(loc(N), dep(supplies), tab(_), phone(ericsson), pc(_), bev(_)).					%%13.  Ο εργαζόμενος από το τμήμα προμηθειών έχει ericsson.

human(loc(N), dep(_), tab(_), phone(android), pc(_), bev(orange_juice)).					%%12.  O εργαζόμενος που έχει android πίνει πορτοκαλάδα.
human(loc(N), dep(_), tab(_), phone(i_phone), pc(macbook_air), bev()).			%%6.   Ο εργαζόμενος που έχει iphone έχει και macbook air.
human(loc(N), dep(_), tab(yellow), phone(blackberry), pc(_), bev(_)).			%%7.   O εργαζόμενος που έχει blackberry έχει το κίτρινο γραφείο.	
human(loc(3), dep(_), tab(_), phone(_), pc(_), bev(milk)).						%8.   Γάλα πίνει ο εργαζόμενος στο μεσαίο γραφείο.


%%10.  Ο εργαζόμενος που έχει nokia έχει το γραφείο που βρίσκεται δίπλα από το γραφείο του εργαζόμενου με το netbook. 	
				
human(loc(N), dep(_), tab(_), phone(nokia), pc(_), bev(_)):-
	(N2 is N+1 , member(N2,[1,2,3,4,5]) ;  N2 is N-1, (member(N2,[1,2,3,4,5]))) , human(loc(N2), dep(_), tab(_), phone(_), pc(netbook), bev(_)).
	
	
%%11.  O εργαζόμενος με το blackberry βρίσκεται δίπλα από τον εργαζόμενο που έχει windows 7 laptop.
human(loc(N), dep(_), tab(_), phone(blackberry), pc(_), bev(_)):-
	(N2 is N+1 , member(N2,[1,2,3,4,5]) ;  N2 is N-1, (member(N2,[1,2,3,4,5]))) , human(loc(N2), dep(_), tab(_), phone(_), pc(windows_7), bev(_)).



%%14.  O εργαζόμενος από το τμήμα διεθνών σχέσεων έχει γραφείο που είναι δίπλα στο μπλε γραφείο.

human(loc(N), dep(_), tab(blue), phone(_), pc(_), bev(_)):-			
	(N2 is N + 1, member(N2,[1,2,3,4,5]) ;  N2 is N - 1, member(N2,[1,2,3,4,5])), human(loc(N2), dep(international_relations),tab(_), phone(_), pc(_), bev(_)).



%%5.   Το πράσινο γραφείο είναι στα δεξιά του μπεζ γραφείου. 

human(loc(N), dep(_), tab(green), phone(_), pc(_), bev(_)):- %from 5 we know that beige tab has the green tab to the right, so green tab may be from location 2 to 5.
	N1 is N - 1, member(N1, [1,2,3,4,5]), human(loc(N1), dep(_), tab(beige), phone(_), pc(_), bev(_)).
	
	
/*add(L, Cl):- %add a newly known property on a human based on location
	retract(human_l(L, D, T, P, Pc, B)),
	((Cl = dep(_), assert(human_l(L, Cl, T, P, Pc, B))) ; 
	(Cl = tab(_), assert(human_l(L, D, Cl, P, Pc, B))) ; 
	(Cl = phone(_), assert(human_l(L, D, T, Cl, Pc, B))) ; 
	(Cl = pc(_), assert(human_l(L, D, T, P, Cl, B))) ; 
	(Cl = bev(_), assert(human_l(L, D, T, P, Pc, Cl)))).*/
	
	
	
/*green_right_of_beige(GL):-
	find_beige_loc(BL), GL is BL + 1.*/
	


/*search_bev_location(B, L):-
	human(L, _, _, _, _, bev(B)), check_l(L).
	
search_dep_location(D, L):-
	human(L, dep(D), _, _, _, _), check_l(L).
	
check_l(loc(_)).








human(loc(1), dep(), tab(yellow), phone(), pc(), bev()).  %% From 1,9,15 yellow loc = 1 because from 15 loc 1 has red or yellow. from 9 int_rel is in loc 1 so informatics(red) can't be in loc 1. Also red loc =5 or 3 %%16%%


%%colors
%%y b be g r 
%%y b r be g 

%%bevareges
%%- - m c -
%%- - m - c

%%dep
%%inter - inf - -
%%inter - - - inf

%%phones
%%bb - - - - apo 7 kai 16 %%17%%

%%pcs
%%- w7 - - - apo 11 kai 17*/
				
		
%search all the possible true values for location,department and phone, given the tab and beverage
%we search hints with unknown tab and bevarege

/*human(loc(N), dep(D), tab(green), phone(P), pc(Pc), bev(coffe)):- 	
	human(loc(N),dep(D),tab(),phone(),pc(),bev()), human(loc(),dep(),tab(),phone(P),pc(Pc),bev()) ; 
	%human(loc(),dep(D),tab(),phone(),pc(Pc),bev()), human(loc(N),dep(),tab(),phone(P),pc(),bev()) ; 
	%human(loc(N),dep(),tab(),phone(),pc(Pc),bev()), human(loc(),dep(D),tab(),phone(P),pc(),bev()).*/
	
	
colorsd([red, green, blue, yellow, beige]).
departmentsd([informatics, organization_and_administration, iconomics, international_relations, supplies]).
locationsd([1,2,3,4,5]).
phonesd([i_phone, blackberry, android, ericsson, nokia]).
pcsd([macbook_pro, macbook_air, windows_7, netbook, windows_xp]).
bevaregesd([coffe, tea, milk, orange_juice, water]).


