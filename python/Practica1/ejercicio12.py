anim={'Gato Montes':6,'Yacare overo':3,'Boa acuatica':4}
for animal in anim:
    string = ''
    num = 0
    for x in animal:
        if num == anim[animal]:
            string = string + x +' '
        else:
            string = string + '_ '
        num=num+1
    print(string)
