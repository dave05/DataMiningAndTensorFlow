# solving equations numerically

# basic helper function
def left(e):
  return e[0]
def op(e):
  return e[1]
def right(e):
  return e[2]

#a function check if a variable is the equation.
def isInside(v,e):
  if v==e[0] :
      return True
  if len(e) <= 1:
      return False
  return isInside(v,left(e)) or isInside(v,right(e))

def solve(v,f):
    if isInside(v,f):
        if v==left(f):
            print("be here too", f)
            return f
        else:
            if op(left(f)) == '+':
                solvingAdd(v,f)
            elif op(left(f)) == '-':
                solvingSubstract(v,f)
            elif op(left(f)) == '*':
                solvingMultiply(v,f)
            else:
                solvingDivide(v,f)
    else:
        print("here too")
        return None

# basic rules
#Addition
def solvingAdd(v,f):
    if isInside(v,left(left(f))):
        h= (left(left(f)),'=',(right(f),'-',right(left(f))))
        solve(v,h)
    else:
        h=(right(left(f)),'=',(right(f),'-',left(left(f))))
        solve(v,h)
#subtraction
def solvingSubstract(v,f):
    if isInside(v,left(left(f))):
        h= (left(left(f)),'=',(right(f),'+',right(left(f))))
        #print(h)
        solve(v,h)
    else:
        h=(right(left(f)),'=',(left(left(f)),'-',right(f)))
        solve(v,h)
#multiplication
def solvingMultiply(v,f):
    if isInside(v,left(left(f))):
        h= (left(left(f)),'=',(right(f),'/',right(left(f))))
        solve(v,h)
    else:
        h=(right(left(f)),'=',(right(f),'/',left(left(f))))
        #print(h)
        #print(left(h))
        #print('x'==left(h))
        solve(v,h)
#division
def solvingDivide(v,f):
    if isInside(v,left(left(f))):
        h= (left(left(f)),'=',(right(f),'*',right(left(f))))
        solve(v,h)
    else:
        h=(right(left(f)),'=',(left(left(f)),'/',right(f)))
        solve(v,h)
e = (('x','+','b'),'=','y')
d= solve('x',e)
print(d)
#print(left(left(e)))
#print(isInside('x',e))
