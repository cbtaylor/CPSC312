-- A Few Tests

let b = generateGridn 3

let b6 = sTrToBoard "WW--W-W---W--BBB-B-"

let state = zip b6 b

let slides = generateSlides b 3

let jumps = generateLeaps b 3

-- TEST: generateSlides
generateSlides b 3

-- TEST: generateLeaps
generateLeaps b 3

-- TEST: boardEvaluator
boardEvaluator B [] 3 b3 True

-- TEST: changeInState
changeInState ((0,0),(0,1)) W state

-- TEST: nextBoard
nextBoard W state ((0,0),(0,1))

-- TEST: generateNewStates
generateNewStates b6 [[W,W,D,D,W,D,D,D,D,D,W,D,D,B,W,B,D,B,D]] b slides jumps W

-- TEST: generateTree
generateTree b0 [] b slides jumps W 2 3

