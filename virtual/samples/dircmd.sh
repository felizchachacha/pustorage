#! /bin/sh +x
f_error=/tmp/jcjerr$$.txt
f_list1=/tmp/jcjlst1$$.txt
f_list2=/tmp/jcjlst2$$.txt
f_temp=/tmp/jcjtmp$$.txt
\rm -f $f_error $f_list1 $f_list2 $f_temp
prog=`basename $0`
if [ $# -ne 2 ] ; then
	echo "Usage : $prog directory1 directory2"
	exit 1
fi
dir1="$1"
dir2="$2"
error() {
	echo "$prog : ERREUR $1"
	[ -s "$f_error" ] && cat "$f_error"
}
error_and_quit() {
	error "$1"
	\rm -f $f_error $f_list1 $f_list2 $f_temp
	exit 1
}
echo "checking parameters"
cd $dir1 2>$f_error
[ $? -ne 0 ] && error_and_quit "when cd in $dir1"
cd $dir2 2>$f_error
[ $? -ne 0 ] && error_and_quit "when cd in $dir2"
echo "building lists of files"
cd $dir1 2>$f_error
[ $? -ne 0 ] && error_and_quit "when cd in $dir1"
find * -type f -print > $f_list1 2>$f_error
[ $? -ne 0 ] && error_and_quit "when find in $dir1"
[ -s "$f_error" ] && error_and_quit "when find in $dir1"
cd $dir2 2>$f_error
[ $? -ne 0 ] && error_and_quit "when cd in $dir2"
find * -type f -print > $f_list2 2>$f_error
[ $? -ne 0 ] && error_and_quit "when find in $dir2"
[ -s "$f_error" ] && error_and_quit "when find in $dir2"
echo "comparison"
sort $f_list1 > $f_temp 2>$f_error
[ $? -ne 0 ] && error_and_quit "when sorting list or files in $dir1"
mv $f_temp $f_list1
[ $? -ne 0 ] && error_and_quit "when rewriting list or files in $dir1"
sort $f_list2 > $f_temp 2>$f_error
[ $? -ne 0 ] && error_and_quit "when sorting list or files in $dir2"
mv $f_temp $f_list2
[ $? -ne 0 ] && error_and_quit "when rewriting list or files in $dir2"
comm -23 $f_list1 $f_list2 > $f_temp 2>$f_error
[ $? -ne 0 ] && error_and_quit "when 1rst comparing list or files"
if [ -s $f_temp ] ; then
	echo "MISSING IN $dir2 :"
	cat $f_temp
	echo
fi
comm -13 $f_list1 $f_list2 > $f_temp 2>$f_error
[ $? -ne 0 ] && error_and_quit "when 2nd comparing list or files"
if [ -s $f_temp ] ; then
	echo "MISSING IN $dir1 :"
	cat $f_temp
	echo
fi
comm -12 $f_list1 $f_list2 > $f_temp 2>$f_error
[ $? -ne 0 ] && error_and_quit "when 3rd comparing list or files"
for i in `cat $f_temp` ; do
#for i in toto ; do
	f1=${dir1}/$i
	f2=${dir2}/$i
	j=`md5sum $f1 2>$f_error`
	if [ $? -ne 0 ] ; then
		error "when md5sum $f1"
	else
		md1=`echo $j | awk '{ print $1 }' 2>$f_error`
		if [ $? -ne 0 ] ; then
			error "when awk after md5sum $f1"
		else
			j=`md5sum $f2 2>$f_error`
			if [ $? -ne 0 ] ; then
				error "when md5sum $f2"
			else
				md2=`echo $j | awk '{ print $1 }' 2>$f_error`
				if [ $? -ne 0 ] ; then
					error "when awk after md5sum $f2"
				elif [ "$md1" != "$md2" ] ; then
					echo "DIFFERENCE between $f1 ($md1) and $f2 ($md2) !" 
				else
					echo "OK : $i" 
				fi
			fi
		fi
	fi
done
\rm -f $f_error $f_list1 $f_list2 $f_temp
exit 0
