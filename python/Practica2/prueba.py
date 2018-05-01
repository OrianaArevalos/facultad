from pattern.es import parsetree  
s = 'The mobile web is more important than mobile apps.'
s = parsetree(s) 
print(s)
for sentence in s: 
    print (sentence)
    for chunk in sentence.chunks:
        print(chunk)
        for word in chunk.words:
            print (word)