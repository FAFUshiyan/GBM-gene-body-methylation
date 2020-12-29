#!perl -w
my %hash;
open (IN,$ARGV[0]) or die "";
$out = $ARGV[0];
$out =~ s/txt/average/g;
open (OUT,">$out") or die "";
while (<IN>){
chomp;
@p = split (/\s+/,$_);
$a = $p[0];
foreach $i(1..$#p){
$level = $p[$i];
$hash{$i}->{$a}=$level;
}
}
close IN;
foreach $i(1..60){
foreach $a(sort keys %{$hash{$i}}){
next if ($hash{$i}->{$a} eq 'NA');
$c += $hash{$i}->{$a};
$n ++;
#print "$hash{$i}->{$a}\n";
}
$mean = $c/$n;
print OUT "$mean\t";
$c = 0;
$n = 0;
}
print OUT "\n";
