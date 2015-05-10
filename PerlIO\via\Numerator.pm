 package PerlIO::via::Numerator;
   our $NumeratorHash={};
sub PUSHED
    {
     my ($class,$mode,$fh) = @_;
     # When writing we buffer the data
     my $buf = '';
     return bless \$buf,$class;
    }
    sub FILL
    {
     my ($obj,$fh) = @_;
     my $line = <$fh>;
     return (defined $line) ? substr($line,index($line,' ')+1) : undef;
    }
    sub WRITE
    {
      ($package)=caller;
     my ($obj,$buf,$fh) = @_;
      $$obj.= ++$NumeratorHash->{$package}{$fh} . ' '  if !$NumeratorHash->{$package}{$fh};
      while(1){
         my $ind=index($buf,"\n");
         if($ind==-1){
            $$obj .=$buf;
            last;
         }
         else {
            $$obj .=substr($buf,0,$ind+1) . ++$NumeratorHash->{$package}{$fh} . ' ';  
            $buf=substr($buf,$ind+1);
         }
      }
     return length($buf);
    }
=comment
    sub WRITE
    {
      ($package)=caller;
     my ($obj,$buf,$fh) = @_;
     if($buf ne $\){
        $$obj .= ++$NumeratorHash->{$package}{$fh} . ' ' . $buf;
     }
     else {
        $$obj.=$buf; 
     }
     return length($buf);
    }
=cut
    sub FLUSH
    {
     my ($obj,$fh) = @_;
     print $fh $$obj or return -1;
     $$obj = '';
     return 0;
    }
    1;
