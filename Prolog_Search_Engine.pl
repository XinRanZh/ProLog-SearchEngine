article(("Hello", ["asdf", "jkl"], ["wtf", "123"])).

fitTitle(Key, (Title, Keywords, Element)):- Key = Title.

search(Key, Article):- article(Article), fitTitle(Key, Article);article(Article), fitKeywords(Key, Article).

fitKeywords(Key, (Title, Keywords, Element)):- member(Key, Keywords).