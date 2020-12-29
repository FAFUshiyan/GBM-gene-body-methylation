from scipy import stats
import sys


def main():
        if len(sys.argv) < 2:
                exit()
        fn = sys.argv[1]
        p_value = sys.argv[2]
        fi = open(fn, "r")
        fo = open(fn+".out", "w")
        for line in fi:
                data = line.strip().split()
                if data[0] == 'chr':
                        continue
                n = int(data[2])
                k = int(data[1])
                binomial = stats.binom_test(k, n, float(p_value),alternative='greater')
                fo.write(line.strip()+"\t"+str(binomial)+"\n")
        fi.close()
        fo.close()


if __name__ == "__main__":
        main()
