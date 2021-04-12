:- include('Prolog_Search_Engine.pl').
:- dynamic(article/1).



start() :-
    write('Type search to use the search engine, or add to add an article to the knowledge base'),
    nl,
    read(Choice),
    (
        Choice == 'search' ->
        write('Type in your search query'),
        read(Input),
        search_k(Input, Response),
        write(Response)
        ;
        Choice == 'add' ->
        write('Type in the name of the article you wish to add'),
        read(Name),
        add_article(Name)


    ).

