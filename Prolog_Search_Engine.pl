% Pre-defiened Articles inside the Knowledge Base
% In Case of (Title, Keywords, Content)

:- include('googleapi.pl').

article(("Hello", "love sweet word", "I Love Julia Liao")).
article(("meow", "word sweet", "Nice Job, Well Done")).

% Title that fully fit the Title is the first to be pick
fitTitle(Key, (Title, Keywords, Content)):- Key = Title.

% Search Keyword that fully included in Keywords with correct order have the second rank
fitKeywordsDirect(Key, (Title, Keywords, Content)):- isSubString(Key, Keywords).

% Search Keyword that NOT ALL included in Keywords OR with incorrect order have the second rank
fitKeywordsSplit(Key, (Title, Keywords, Content)):- checkSplit(Key, Keywords).

% Search Keyword that fully included in Keywords with correct order have the second rank
fitContentDirect(Key, (Title, Keywords, Content)):- isSubString(Key, Content).

% Search Keyword that NOT ALL included in Keywords OR with incorrect order have the second rank
fitContentSplit(Key, (Title, Keywords, Content)):- checkSplit(Key, Content).

% Remove Duplicate Result
search_k(Key, Articles):- distinct(search_mayDuplicate(Key, Articles)).

add_article(X) :- assertz(article(X)).

search_mayDuplicate(Key, Articles):-
                        article(Articles), fitTitle(Key, Articles);
                        article(Articles), fitKeywordsDirect(Key, Articles);
                        article(Articles), fitKeywordsSplit(Key, Articles);
                        article(Articles), fitContentDirect(Key, Articles);
                        article(Articles), fitContentSplit(Key, Articles); 
                        % Search in google if cannot found
                        search_g(Key, Articles).


% First Split the String by SPACE into a list of words
checkSplit(Keywords, String):- split_string(Keywords, " ", ".", KeyList), checkSplitList(KeyList, String).

% For every splited single words, fit with Keywords/Content
checkSplitList([H|T], String):- isSubString(H, String); T \= [], checkSplitList(T, String).

% First Convert both the to-be-test Substring and full-String to Lists of ASCII Code then use append in reverse way to see if it's a subList(substring)
isSubString(SubString, String):- string_codes(SubString, X), string_codes(String, Y), append(_, Any, Y), append(X, _, Any), X \= [].