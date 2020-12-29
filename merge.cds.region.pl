#!perl -w
my %hash;
open (IN,$ARGV[0]) or die "";
while (<IN>){
        chomp;
        @tmp = split (/\s+/,$_);
        if ($tmp[4] =~ /t1/){
        $tmp[4] =~ s/\.t1..*//g;
        $mu = $tmp[5]."-".$tmp[6];
        $hash{$tmp[4]}{$tmp[1]} = $mu;
                }
        }
        close IN;
        
foreach $i(sort keys %hash){
        $mt = 0;
        $nt = 0;
        print "$i\t";
        foreach $l(sort keys %{$hash{$i}}){
                $num = $hash{$i}{$l};
                my ($na,$nb) = split (/-/,$num);
                $mt += $na;
                $nt += $nb;
                }
                print "$mt\t$nt\n";
        }
