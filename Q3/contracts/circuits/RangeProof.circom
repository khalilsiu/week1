pragma circom 2.0.0;

include "../../node_modules/circomlib/circuits/comparators.circom";

template Multiply2(){
   signal input in1;
   signal input in2;
   signal output out;

   out <== in1 * in2;
}

template RangeProof(n) {
    assert(n <= 252);
    signal input in; 
    signal input range[2]; 
    signal output out;
    component multiplier = Multiply2();
    component comparators[2];

    component lte = LessEqThan(n);
    component gte = GreaterEqThan(n);

    lte.in[0] <== in;
    lte.in[1] <== range[0];

    gte.in[0] <== in;
    gte.in[1] <== range[1];

    comparators[0] <== lte.out;
    comparators[1] <== gte.out;

    multiplier.in1 <== comparators[0].out;
    multiplier.in2 <== comparators[1].out;

    out <== multiplier.out;
}