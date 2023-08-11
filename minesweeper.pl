#!/usr/bin/perl
use strict;
use warnings;

my @board=();
my @mines=();
my @mine_board=();
my $value;
my $count_of_boxes=54;
for(my $i = 0;$i<64;$i++){
	$board[$i]='.';
	$mine_board[$i]=0;
}
sub printBoard{
	system("clear");
print"\n*******MINESWEEPER*******";
print"\n\n\n";
    print"X | ";
    for(my $c=0;$c<8;$c++){
        print $c," | ";
    }
    print "\n";
    for(my $row =0;$row<8;$row++){
        print "$row ";
    	print "| ";
    	for(my $col=0;$col<8;$col++){
    		print $board[$row*8 + $col]," | ";
    	}
    	print "\n";
    }
}
printBoard();
sub mineCreation{
for (my $i = 0; $i < 10; $i++) {
    my $rand_num;
    while (1) {
        $rand_num = int(rand(64));
        my $flag = 1;
        for (my $j = 0; $j < $i; $j++) {
            if ($rand_num == $mines[$j]) {
                $flag = 0;
                last;
            }
        }
        if ($flag == 1) {
            $mines[$i] = $rand_num;
            last;
        }
    }
}
}
mineCreation();


#for(my $i = 0;$i<10;$i++){
#	print $mines[$i]," ";
#}
foreach my $i (@mines){
    $mine_board[$i]=1;
}


=begin
sub assignVal {
    my $r = $_[0];
    my $c = $_[1];
    my $loc = $r*8 + $c;
    my @neighbours = (1,1,1,1,1,1,1,1);
    #neighbours = (NW,N,NE,W,E,SW,S,SE);
    print"$loc\n";
    my $count =0;
    if($mine_board[$loc]==1){
        print"\nYou hit a mine.\n";
        print"GAME OVER\n";
        exit(0);
        print"debugger";
    }
    if($row==0){
        $neighbours[$0]=0;
        $neighbours[$1]=0;
        $neighbours[$2]=0;
    }
    if($row==7){
        $neighbours[$5]=0;
        $neighbours[$6]=0;
        $neighbours[$7]=0;
    }
    if($col==0){
        $neighbours[$3]=0;
    }
    if($col==7){
        $neighbours[$4]=0;
    }
    
    
    
}
my $val = assignVal($row,$col);
print"Assigned val",$val;
=cut

sub checkPosition {
    my ($row, $col) = @_;
    my $index = $row * 8 + $col;
    if ($mine_board[$index] == 1) {
        revealBoard();
	print "Sorry, that's a mine.\nGame over.\n";
        exit;
    }
    my $count = 0;
    for (my $i = -1; $i <= 1; $i++) {
        for (my $j = -1; $j <= 1; $j++) {
            my $r = $row + $i;
            my $c = $col + $j;
            if ($r >= 0 && $r < 8 && $c >= 0 && $c < 8) {
                my $neighbor_index = $r * 8 + $c;
                if ($mine_board[$neighbor_index] == 1) {
                    $count++;
                }
            }
        }
    }
    return $count;
}
sub mineCount {
    my ($row, $col) = @_;
    my $index = $row * 8 + $col;
    my $count = 0;
    if ($mine_board[$index] == 1) {
        return -1;
    }
    for (my $i = -1; $i <= 1; $i++) {
        for (my $j = -1; $j <= 1; $j++) {
            my $r = $row + $i;
            my $c = $col + $j;
            if ($r >= 0 && $r < 8 && $c >= 0 && $c < 8) {
                my $neighbor_index = $r * 8 + $c;
                if ($mine_board[$neighbor_index] == 1) {
                    $count++;
                }
            }
        }
    }
    return $count;
}

for(my $i=0;$i<8;$i++){
    for(my $j=0;$j<8;$j++){
        my $val = mineCount($i,$j);
        if($val==0){
            $board[$i*8 +$j]=0;
            $count_of_boxes-=1;
        }
        #elsif($val==-1){
        #    $board[$i*8 +$j]='X';
        #}
        
    }
}
sub revealBoard {
    foreach my $i (@mines){
        $board[$i]='X';
    }
    printBoard();
}
my $continue = 1;
my $startg = 0;
print "Start the game?(1/0)";
$startg=<STDIN>;
if($startg>0){
printBoard();
while($continue>0){
    print"\nEnter row and column:\n";
    my $row = <STDIN>;
    my $col = <STDIN>;
    my $val = checkPosition($row,$col);
    if($board[$row*8 + $col] eq '.'){
        $board[$row*8 + $col]=$val;
        $count_of_boxes-=1;
    }
    printBoard();
    if($count_of_boxes==0){
	revealBoard();
        print("Congratulations!!!\n");
        print("You won the game!\n");
        exit(0);
    }
    print"\nContinue the game?(1/0)";
    $continue=<STDIN>;
    if($continue==0){
        revealBoard();
	print "\nGoodbye.\n";
    }
}
}
else{
exit(0);
}
