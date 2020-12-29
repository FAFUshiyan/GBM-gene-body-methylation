#!perl -w 
my $cg_count = 0;
my $chg_count = 0;
my $chh_count = 0;
open (IN,$ARGV[0]) or die "";
$/ = '>';
<IN>;
while (<IN>){
        chomp;
        my ($name,$seq) = split (/\n/,$_,2);
        $seq =~ s/\s+//g;
        $new_seqcg = uc $seq;
                $new_seqchg = uc $seq;
                $new_seqchh = uc $seq;
                $new_seqchh =~ s/CAA/R/g;
                $new_seqchh =~ s/CAC/R/g;
                $new_seqchh =~ s/CAT/R/g;
                $new_seqchh =~ s/CCA/R/g;
                $new_seqchh =~ s/CCC/R/g;
                $new_seqchh =~ s/CCT/R/g;
                $new_seqchh =~ s/CTA/R/g;
                $new_seqchh =~ s/CTC/R/g;
                $new_seqchh =~ s/CTT/R/g;
                $new_seqcg =~ s/CG/Y/g;
                $new_seqchg =~ s/CAG/W/g;
                $new_seqchg =~ s/CTG/W/g;
                $new_seqchg =~ s/CCG/W/g;
                my $number_chh = ($new_seqchh =~ tr/R/P/);
                my $number_cg = ($new_seqcg =~ tr/Y/L/);
                my $number_chg = ($new_seqchg =~ tr/W/S/);
                $chh_count += $number_chh;
                $cg_count += $number_cg;
                $chg_count += $number_chg;
        }
        close IN;
$tcg = `grep -w CG $ARGV[1]|grep + |awk '{if(\$8>=2) print}'|wc -l`;
$tcg =~ s/\n//g;
$tchg = `grep -w CHG $ARGV[1]|grep + |awk '{if(\$8>=2) print}'|wc -l`;
$tchg =~ s/\n//g;
$tchh = `grep -w CHH $ARGV[1]|grep + |awk '{if(\$8>=2) print}'|wc -l`;
$tchh =~ s/\n//g;
$pcg = 1-($tcg/$cg_count);
$pchg = 1-($tchg/$chg_count);
$pchh = 1-($tchh/$chh_count);

system ("python Binomial.py  $ARGV[2]  $pcg ");
system ("python Binomial.py  $ARGV[3]  $pchg" );
system ("python Binomial.py  $ARGV[4]  $pchh" );

system ("Rscript FDR-BH.R   $ARGV[2].out  $ARGV[2].qvalue" );
system ("Rscript FDR-BH.R   $ARGV[3].out  $ARGV[3].qvalue");
system ("Rscript FDR-BH.R   $ARGV[4].out  $ARGV[4].qvalue");
