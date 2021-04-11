article(("Hello", "love sweet word", "I Love Julia Liao")).
article(("meow", "word sweet", "Nice Job, Well Done")).

fitTitle(Key, (Title, Keywords, Content)):- Key = Title.

fitKeywordsDirect(Key, (Title, Keywords, Content)):- isSubString(Key, Keywords).

fitKeywordsSplit(Key, (Title, Keywords, Content)):- checkSplit(Key, Keywords).

fitContentDirect(Key, (Title, Keywords, Content)):- isSubString(Key, Content).

fitContentSplit(Key, (Title, Keywords, Content)):- checkSplit(Key, Content).

search(Key, Articles):- distinct(search_mayDuplicate(Key, Articles)).

search_mayDuplicate(Key, Articles):- 
                        article(Articles), fitTitle(Key, Articles); 
                        article(Articles), fitKeywordsDirect(Key, Articles);
                        article(Articles), fitKeywordsSplit(Key, Articles); 
                        article(Articles), fitContentDirect(Key, Articles);
                        article(Articles), fitContentSplit(Key, Articles).


checkSplit(Keywords, String):- split_string(Keywords, " ", ".", KeyList), checkSplitList(KeyList, String).

checkSplitList([H|T], String):- isSubString(H, String); T \= [], checkSplitList(T, String).

isSubString(SubString, String):- string_codes(SubString, X), string_codes(String, Y), append(_, Any, Y), append(X, _, Any), X \= [].