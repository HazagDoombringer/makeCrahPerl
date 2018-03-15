#!/usr/bin/perl
#7i1eoFiHuFAeAeBF
use strict;
use File::Basename;
use warnings;
# use Switch;
use Cwd;

my $texTemplate = "template.tex";
my $folder = getcwd();

0 == system "perl makeTeamInput.pl" or die "can't generate TeamCrah\n";


#openning local folder
opendir(my $dh, $folder) or die "can't open $folder\n";
#parsing files in local folder
while (my $file = readdir $dh) {
    #checking if file is a .txt doc
    if($file =~ m@^input(.*)?\.txt$@){
        #print "\tThis file is an input\n";
        #openning .txt file
        print ">\ttreating $file\n";
        open(FILE,"<$file") or die "can't open $file\n";
        my @lines = <FILE>;

        #var used in file
        my $NOM = "";
        my $Prenom = "";
        my $Date = "";
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

        #browse lines of file
        foreach my $line(@lines){
            if($line !~ m@^#@ && $line !~ m@^\s@){
                #PARSING CONTENT

                # NOTE could be optimised by factorising it in subfunctions
                if($line =~m@^NOM:(\w+)\s$@){
                    $NOM = $1;
                }

                if($line =~m@^Prenom:(\w+)\s$@){
                    $Prenom = $1;
                }

                if($line =~m@^Date\(jj/mm/yyyy\):(\d+/\d+/\d+)\s$@){
                    $Date = $1;
                }

                if($line =~m@^num\éro de p\ériode:([\w]+)\s$@){
                    $Periode = $1;
                }

                if($line =~m@^imageS1G:(\\mySunny|\\mySunnyCloudy|\\myRainy|\\myStormy)\s$@){
                    $imageS1G = $1;
                }

                if($line =~m@^imageS2G:(\\mySunny|\\mySunnyCloudy|\\myRainy|\\myStormy)\s$@){
                    $imageS2G = $1;
                }

                if($line =~m@^imageS1A:(\\mySunny|\\mySunnyCloudy|\\myRainy|\\myStormy)\s$@){
                    $imageS1A = $1;
                }

                if($line =~m@^imageS2A:(\\mySunny|\\mySunnyCloudy|\\myRainy|\\myStormy)\s$@){
                    $imageS2A = $1;
                }

                if($line =~m@^imageS1W:(\\mySunny|\\mySunnyCloudy|\\myRainy|\\myStormy)\s$@){
                    $imageS1W = $1;
                }

                if($line =~m@^imageS2W:(\\mySunny|\\mySunnyCloudy|\\myRainy|\\myStormy)\s$@){
                    $imageS2W = $1;
                }

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
        close FILE;

        #read the template and change what needs to be on the new file.tex

        # IN = template.tex   OUT = output.tex
        # read each lines of IN and print it in OUT
        # if lines == %indicator
        # printing in OUT datas readed from input.txt

        open(IN,'<'."$texTemplate") or die "can't open $NOM.tex for reading\n";
        open(OUT,'+>'."$NOM.tex") or die "can't open $NOM.tex for writing\n";
        print "\tout > $NOM.tex\n";
        my @texLines = <IN>;
        foreach my $texLine(@texLines){
            #if line begin with \"\%"
            if($texLine =~ m@^\%@){

                toPrint($texLine,"^\%nom",$NOM);
                toPrint($texLine,"^\%prenom",$Prenom);
                toPrint($texLine,"^\%date",$Date);
                toPrint($texLine,"^\%Pnbp",$Periode);
                toPrint($texLine,"^\%s1meteoG",$imageS1G);
                toPrint($texLine,"^\%s2meteoG",$imageS2G);
                toPrint($texLine,"^\%s1meteoA",$imageS1A);
                toPrint($texLine,"^\%s2meteoA",$imageS2A);
                toPrint($texLine,"^\%s1meteoW",$imageS1W);
                toPrint($texLine,"^\%s2meteoW",$imageS2W);

                toIndent($texLine,"^\%s1gestionC",@S1GC);
                toIndent($texLine,"^\%s2gestionC",@S2GC);
                toIndent($texLine,"^\%s1androidC",@S1AC);
                toIndent($texLine,"^\%s2androidC",@S2AC);
                toIndent($texLine,"^\%s1webC",@S1WC);
                toIndent($texLine,"^\%s2webC",@S2WC);

                toIndent($texLine,"^\%s1objectif",@S1obj);
                toIndent($texLine,"^\%s2objectif",@S2obj);

                toliste($texLine,"^\%s1faitM",@S1FM);
                toliste($texLine,"^\%s2faitM",@S2FM);
                toliste($texLine,"^\%s1HP",@S1HP);
                toliste($texLine,"^\%s2HP",@S2HP);
                toliste($texLine,"^\%s1TC",@S1TC);
                toliste($texLine,"^\%s2TC",@S2TC);

            }
            else{
                #else cp template content to file.tex
                print OUT "$texLine";
            }
        }
        close IN;
        close OUT;

        # Making a checksum to veiw if OUT file changed between two makeCRAH.pl
        # NOTE you can comment from `my $checksum = 0;` to `print "\tchk: $checksum\n\n";` if you want to gain procedural time
        my $checksum = 0;
        open(OUT,'<'."$NOM.tex") or die "can't open $NOM.tex for reading\n";
        my @linesSum = <OUT>;
        foreach my $lineSum(@linesSum){
        $checksum += unpack("%16C*", $lineSum);
        }
        close OUT;
        print "\tchk: $checksum\n\n";
    }
    else{
    #     print "\n";
    }
}


closedir $dh;


sub toPrint{
  (my $inputLine, my $regex, my $data) = @_;
  if($inputLine =~ m@$regex@){
    print OUT "$data";
  }
}

sub toIndent{
  (my $inputLine, my $regex, my @datas) = @_;
#   print ">arg: $_\n" foreach @_;
  if($inputLine =~ m@$regex@){
    my $flag = 0;
    foreach my $data(@datas){
      if($flag == 0){
	$inputLine = "\\subsubsection*\{$data\}\n";
	$flag += 1;
      }
      else{
	$inputLine = "$data\n";
	$flag -= 1;
      }
      print OUT $inputLine;
    }
  }
}


sub toliste{
  (my $inputLine, my $regex, my @datas) = @_;
  if ($inputLine =~ m@$regex@){
    print OUT "\\begin{itemize}\n";
    foreach my $data(@datas){
      print OUT "\t\\item $data\n";
    }
    print OUT "\\end{itemize}\n";
  }
}

# ### DEPRECATED ### #
# ### tabulars are too hard to proceduarly fill without making them unreadable ### #
sub totable{
  (my $inputLine, my $regex, my @datas) = @_;
  if($inputLine =~ m@$regex@){
    my $flag = 0;
    print OUT "\\begin{tabular}{|l|l|}
\\hline Objectifs & état \\\\ \\hline ";
    foreach my $data(@datas){
      if($flag == 0){
	$inputLine = "$data \&";
	$flag += 1;
      }
      else{
	$inputLine = " $data \\\\";
	$flag -= 1;
      }
      print OUT $inputLine;
    }
    print OUT "\\hline \\end{tabular}\n"
  }
}

# 4eoGCuyEAyEoi9CeGEo2oe9eyEiB2i26EoFGoBi4EeB2uoFi
