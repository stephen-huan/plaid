# Putting it All Together

There are two main ways to attach the top PCB to the bottom PCB.
One is the way described in the Plaid
[build guide](https://github.com/hsgw/plaid/blob/master/doc/en/complete.md),
which takes advantage of the fact that a M2 nut is 1.6mm high, and so is the
PCB. Thus, 2 PCB layers and 3 nuts are exactly 5*1.6mm = 8mm high.
So a 8mm M2 screw inserted from the top of the top PCB, two nuts between it and
the bottom PCB, and then fastened with the final nut will exactly fit.
However, in my experience, the nuts fall out.

A different way to attach the two PCBs together is with a 3mm spacer.
2*1.6mm + 3mm = 6.2mm, so the screws have to be less than 3mm long.
See the photo for how the setup works.
First, insert one 3mm screw from the top of the top PCB, and screw the spacer
onto it. Then, screw another 3mm screw from the bottom of the bottom PCB into
the existing spacer and it will fasten.

![side](../img/side.png)

