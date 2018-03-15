#!/usr/bin/perl
#7i1eoFiHuFAeAeBF
use strict;
use File::Basename;
use warnings;
use Time::localtime;

use Cwd;

my $texTemplate = "template.tex";
my $folder = getcwd();


#var used in file
my $NOM = "TEAM";
my $Prenom = "BILLY";
my $Date = localtime->mday()."/".(localtime->mon()+1)."/".(localtime->year()+1900);
my $Periode = "";

my $imageS1G = "";
my $imageS2G = "";
my $imageS1A = "";
my $imageS2A = "";
my $imageS1W = "";
my $imageS2W = "";

my @S1GC = ();
my @S1AC = ();
my @S1WC = ();

my @S2GC = ();
my @S2AC = ();
my @S2WC = ();

my @S1obj = ();
my @S1FM = ();
my @S1HP = ();
my @S1TC = ();

my @S2obj = ();
my @S2FM = ();
my @S2HP = ();
my @S2TC = ();


#openning local folder
opendir(my $dh, $folder) or die "can't open $folder\n";
#parsing files in local folder
while (my $file = readdir $dh) {
    #checking if file is a .txt doc
    if($file =~ m@^input(.*)?\.txt$@){
        #print "\tThis file is an input\n";
        #openning .txt file
        print ">\ttreating $file for teamCRAH\n";
        open(IN,"<$file") or die "can't open $file for teamCRAH\n";
        my @lines = <IN>;

        #browse lines of file
        foreach my $line(@lines){
            if($line !~ m@^#@ && $line !~ m@^\s@){
                #PARSING CONTENT

                if($line =~m@^S1GC:(.*):(.*)\s$@){
                    push @S1GC,$1;
                    push @S1GC,$2;
                }
                if($line =~m@^S2GC:(.*):(.*)\s$@){
                    push @S2GC,$1;
                    push @S2GC,$2;
                }

                if($line =~m@^S1AC:(.*):(.*)\s$@){
                    push @S1AC,$1;
                    push @S1AC,$2;
                }
                if($line =~m@^S2AC:(.*):(.*)\s$@){
                    push @S2AC,$1;
                    push @S2AC,$2;
                }

                if($line =~m@^S1WC:(.*):(.*)\s$@){
                    push @S1WC,$1;
                    push @S1WC,$2;
                }
                if($line =~m@^S2WC:(.*):(.*)\s$@){
                    push @S2WC,$1;
                    push @S2WC,$2;
                }

                if($line =~m@^S1obj:(.*)\|(.*)\s$@){
                    push @S1obj,$1;
                    push @S1obj,$2;
                }

                if($line =~m@^S1FM:(.*)\s$@){
                    push @S1FM,$1;
                }

                if($line =~m@^S1HP:(.*)\s$@){
                    push @S1HP,$1;
                }

                if($line =~m@^S1TC:(.*)\s$@){
                    push @S1TC,$1;
                }

                if($line =~m@^S2obj:(.*)\|(.*)\s$@){
                    push @S2obj,$1;
                    push @S2obj,$2;
                }

                if($line =~m@^S2FM:(.*)\s$@){
                    push @S2FM,$1;
                }

                if($line =~m@^S2HP:(.*)\s$@){
                    push @S2HP,$1;
                }

                if($line =~m@^S2TC:(.*)\s$@){
                    push @S2TC,$1;
                }
            }
        }
        close IN;
    }
}


open(OUT,">input_Team.txt") or die "can't open input_Team.txt for teamCRAH\n";

# my $NOM = "TEAM";
# my $Prenom = "BILLY";
# my $Date = localtime->mday()."/".(localtime->mon()+1)."/".(localtime->year()+1900);

toPrint("NOM",$NOM);
toPrint("Prenom",$NOM);
toPrint("Date\(jj/mm/yyyy\)",$Date);

toDivide("S1GC",":",@S1GC);
toDivide("S2GC",":",@S2GC);

toDivide("S1AC",":",@S1AC);
toDivide("S2AC",":",@S2AC);

toDivide("S1WC",":",@S1WC);
toDivide("S2WC",":",@S2WC);

toDivide("S1obj","|",@S1obj);
toDivide("S2obj","|",@S2obj);

toPrint("S1FM",@S1FM);
toPrint("S2FM",@S2FM);

toPrint("S1HP",@S1HP);
toPrint("S2HP",@S2HP);

toPrint("S1TC",@S1TC);
toPrint("S2TC",@S2TC);
close OUT;


sub toPrint{
  (my $tag,my @datas) = @_;
  foreach my $data(@datas){
    print OUT "$tag:$data\n";
  }
}

sub toDivide{
  (my $tag, my $separator, my @datas) = @_;
#   print ">arg: $_\n" foreach @_;
  my $outPutLine = "";
  my $flag = 0;
  foreach my $data(@datas){
    if($flag == 0){
      $outPutLine .= "$tag:$data $separator ";
      $flag += 1;
    }
    else{
      $outPutLine .= "$data\n";
      $flag -= 1;
    }
  }
  print OUT $outPutLine;
}




closedir $dh;

print "\n";
# 4eoGCuyEAyEoi9CeGEo2oe9eyEiB2i26EoFGoBi4EeB2uoFi
