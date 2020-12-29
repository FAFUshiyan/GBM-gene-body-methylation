#!perl -w

my %hash;
while (my $file = glob "/gpfsdata/shiyan/Mango/Meth/metaplot/LF_gene/all.*_C*.txt"){
###metaplot data position;
        $sample = $file;
        $sample =~ s/.txt//g;
        $sample =~ s/\/gp.*.LF_gene\///g;
        open (my $fh,$file) or die "";
        while (<$fh>){
                chomp;
                @tmp = split (/\s+/,$_);
                my $chrm = shift @tmp;
                my $gene = shift @tmp;
                my $meth = join ("\t",@tmp);
                $hash{$gene}->{$sample} = $meth;
                                }
                        close $fh;
        }
open (IM,$ARGV[0]) or die "";
$o = $ARGV[0];
$o =~ s/\.ID//g;
open (CG,">CG.$o.txt") or die "";
open (CHG,">CHG.$o.txt") or die "";
open (CHH,">CHH.$o.txt") or die "";
while (<IM>){
        chomp;
        my $go = $_;
print CG "$go\t";
print CHG "$go\t";
print CHH "$go\t";
$mac = $hash{$go}->{'all.promter_CG'};
$mbc = $hash{$go}->{'all.gene_CG'};
$mcc = $hash{$go}->{'all.down_CG'};
print CG "$mac\t$mbc\t$mcc\n";
$mah = $hash{$go}->{'all.promter_CHG'};
$mbh = $hash{$go}->{'all.gene_CHG'};
$mch = $hash{$go}->{'all.down_CHG'};
print CHG "$mah\t$mbh\t$mch\n";
$mag = $hash{$go}->{'all.promter_CHH'};
$mbg = $hash{$go}->{'all.gene_CHH'};
$mcg = $hash{$go}->{'all.down_CHH'};
print CHH "$mag\t$mbg\t$mcg\n";
        }
close IM;
close CG;       
close CHG;
close CHH;
system("perl get_average2.pl CG.$o.txt");
system("perl get_average2.pl CHG.$o.txt");
system("perl get_average2.pl CHH.$o.txt");
