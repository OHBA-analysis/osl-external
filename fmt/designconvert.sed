# designconvert.sed
# sed script to convert a design.fsf file into MATLAB code to specify
# the design as a structure named fmri
# R Poldrack, 7/1/04

# replace "." with ".c" when they occur within parens
# this is necessary because matlab can't handle struct fields
# whose name is just a number

# works with sed on a mac with command:
# sed -f designconvert.sed design.fsf > design.m

/(*\.[0-9]*)/{
   /\.[0-9]/s/\./.c/g 
}

/set/s/set fmri(/fmri./g
/fmri/s/) /=/g
/"/s/"/'/g
/#/s/#/%/g

/fmri/s/$/;/

# deal with cases where the Rvalue is a string

/con_mode/s/=/='/
/con_mode/s/;/';/

# fix file specification separately
/_files/s/set /fmri./

# create as cell arrays
/_files/y/()/{}/
/_files/s/'/='/
/_files/s/$/;/
