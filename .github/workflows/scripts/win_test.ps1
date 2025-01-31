. venv\Scripts\activate.ps1
python -c "import taichi"
ti diagnose
ti changelog
echo wanted arch: $env:TI_WANTED_ARCHS
pip install -r requirements_test.txt
if ("$env:TI_WANTED_ARCHS".Contains("cuda")) {
    pip install torch==1.10.1+cu113 -f https://download.pytorch.org/whl/cu113/torch_stable.html
} else {
    pip install torch
}
if ("$env:TI_WANTED_ARCHS".Contains("cuda")) {
  python tests/run_tests.py -vr2 -t6 -k "not torch" -a cuda
}
if ("$env:TI_WANTED_ARCHS".Contains("cpu")) {
  python tests/run_tests.py -vr2 -t8 -k "not torch" -a cpu
}
if ("$env:TI_WANTED_ARCHS".Contains("opengl")) {
  python tests/run_tests.py -vr2 -t6 -k "not torch" -a opengl
}
python tests/run_tests.py -vr2 -t2 -k "torch" -a "$env:TI_WANTED_ARCHS"
