# TWMac-TT-OKA
<img src=".\illustration\flow.png" alt="image" style="zoom:33%;" />

**Effective Tensor Completion via Element-wise Weighted Low-rank Tensor Train with Overlapping Ket Augmentation**

Yang Zhang, Yao Wang, Zhi Han, Xi’ai Chen, Yandong Tang

[[Paper Link]](https://arxiv.org/abs/2109.05736)


## Environment Requirements

MATLAB2021a with 

- Parallel Computing Toolbox
- Image Processing Toolbox
- Statistic and Machine Learning Toolbox

The code was tested on Windows 10 with Intel(R) Core(TM) i7-9700 CPU @ 3.00GHz.

## Test

##### OKA quick test

- Run [TestOKA.m](https://github.com/z625715875/TWMac-TT-OKA/blob/main/TestOKA.m) for checking the Overlapping Ket Augmentation procedure.

##### TMacTT-OKA (Only OKA)

- Run [Demo_256x256x3_Lena_TMacTT_OKA.m](https://github.com/z625715875/TWMac-TT-OKA/blob/main/Demo_256x256x3_Lena_TMacTT_OKA.m) for Lena of size [256, 256, 3] with 90% elements missing.
- Run [Demo_256x256x3_Peppers_TMacTT_OKA.m](https://github.com/z625715875/TWMac-TT-OKA/blob/main/Demo_256x256x3_Peppers_TMacTT_OKA.m) for Peppers of size [256, 256, 3] with 90% elements missing.

##### TWMacTT-KA (Only W)

- Run [Demo_256x256x3_Lena_TWMacTT_KA.m](https://github.com/z625715875/TWMac-TT-OKA/blob/main/Demo_256x256x3_Lena_TWMacTT_KA.m) for Lena of size [256, 256, 3] with 90% elements missing.
- Run [Demo_256x256x3_Peppers_TWMacTT_KA.m](https://github.com/z625715875/TWMac-TT-OKA/blob/main/Demo_256x256x3_Peppers_TWMacTT_KA.m) for Peppers of size [256, 256, 3] with 90% elements missing.


##### TWMacTT-OKA (W+OKA) - arbitrary size test (thanks to the proposed OKA scheme

- Run [Demo_91x111x3_Lena.m](https://github.com/z625715875/TWMac-TT-OKA/blob/main/Demo_91x111x3_Lena.m) for a randomly cropped image Lena of size [91, 111, 3].



##### TWMacTT-OKA (W+OKA)

- Run [Demo_256x256x3_Lena_TWMacTT_OKA.m](https://github.com/yzcv/TWMac-TT-OKA/blob/main/Demo_256x256x3_Lena_TWMacTT_OKA.m)  for Lena of size [256, 256, 3] with 90% elements missing.
- Run [Demo_256x256x3_Peppers_TWMacTT_OKA.m](https://github.com/yzcv/TWMac-TT-OKA/blob/main/Demo_256x256x3_Peppers_TWMacTT_OKA.m)  for Peppers of size [256, 256, 3] with 90% elements missing.


For other input images, please tune the hyper-parameter `thl` in the Demo script to obtain the best performance.





