import os
import logging
import re

def collect_integrals(filename, dir=False):
    '''Collects all occurences of INT(...) in a given file or directory'''
    if os.path.exists(filename):
        if dir:  # if filename is a directory
            logging.debug(f"Collecting integrals from directory {filename}")
            onlyfiles = [f for f in os.listdir(
                filename) if (os.path.isfile(os.path.join(filename, f)) and "unreduced" in f)]
            uniques = []
            for file in onlyfiles:
                with open(os.path.join(filename, file), 'r') as f:
                    content = f.read().replace('\n', '')
                    diag_unique = list(
                        set([i.replace(' ', '') for i in re.findall('INT\('+"(.*?)"+'\)', content)]))
                    uniques.append(diag_unique)
            rly_unique = sorted(list(set([j for k in uniques for j in k])))
        else:
            logging.debug(f"Collecting integrals from file {filename}")
            uniques = []
            with open(filename, 'r') as f:
                content = f.read().replace('\n', '')
                diag_unique = list(
                    set(re.findall('INT\('+"(.*?)"+'\)', content)))
                uniques.append(diag_unique)
            rly_unique = sorted(list(set([j for k in uniques for j in k])))
        return rly_unique
    else:
        return []


def print_integrals_reduze(outfile, collected):
    logging.info(f'Writing list of integrals to file {outfile} in Kira format')
    with open(outfile, 'w') as g:
        # write each integral from the list collected
        for intt in collected:
            # my formatting: intt looks like "PL,1,0,-1,1"
            # int.split(',')[0] is "PL"
            # "' '.join(intt.split(',')[1:])" means take ["1", "0", "-1", "1"]
            # and then join the elements of this list using the string " "
            # as glue between each element
            # so in total we wrote: "PL    1 0 -1 1"
            new = intt.split(',')[0] + '   ' + ' '.join(intt.split(',')[1:])
            g.write(new + '\n')


collected = collect_integrals("./tmp", dir = True)
print_integrals_reduze("./external/toreduce.inc", collected)