import re

filename = 'tmp/toreduce.inc'

with open(filename, 'r') as f:
    content = f.read().replace('\n', '')
    diag_unique = list(
        set([i.replace(' ', '') for i in re.findall('INT\('+"(.*?)"+'\)', content)]))
    
with open('external/ints.inc', 'w') as g:
    for intt in diag_unique:
        new = intt.split(',')[0]+'   '+' '.join(intt.split(',')[1:])
        g.write(new+'\n')
    
