morphing1="src/coordinates/morphing1/frame0.csv";
morphing2="src/coordinates/morphing2/frame0.csv";

[a,b,c,cmesh,trinum]=mesh(morphing1,morphing2);
[atform,btform]=affine(a,b,c,cmesh);
