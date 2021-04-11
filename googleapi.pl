:- use_module(library(http/http_client)).
:- use_module(library(http/json)).
:- use_module(library(uri)).


% A url that Contain Correct Api-Key and Search Engine Key
google_url("https://customsearch.googleapis.com/customsearch/v1?key=AIzaSyBerH2Ssk2Z6Cn7savDLYGwb4dYBM_1c6A&cx=8dbbef1031a520106&q=").

% Search Via Google Custon Search Engine
search(Keywords, Response):- google_url(X), 
                             % First Convert every SPACE to +
                             re_replace(" ", "+", Keywords, ValidKeyWord),
                             % Link a valid keyword to URL with API
                             string_concat(X, ValidKeyWord, Url), 
                             % Chase a simple HTTP Get request
                             http_get(Url, Json, []), 
                             % Convert the JSON result to a Dict
                             atom_json_dict(Json, Dict, []), 
                             % I only want the first result, which is the first one in the JSON.item
                             [Head|Tail] = Dict.items, 
                             % Then The Respose is it's Snippet 
                             Response = Head.htmlSnippet.
