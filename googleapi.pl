:- use_module(library(http/http_client)).
:- use_module(library(http/json)).
:- use_module(library(uri)).

google_url("https://customsearch.googleapis.com/customsearch/v1?key=AIzaSyBerH2Ssk2Z6Cn7savDLYGwb4dYBM_1c6A&cx=8dbbef1031a520106&q=").

search(Keywords, Response):- google_url(X), 
                             re_replace(" ", "+", Keywords, ValidKeyWord),
                             string_concat(X, ValidKeyWord, Url), 
                             http_get(Url, Json, []), 
                             atom_json_dict(Json, Dict, []), 
                             [Head|Tail] = Dict.items, 
                             Response = Head.htmlSnippet.
