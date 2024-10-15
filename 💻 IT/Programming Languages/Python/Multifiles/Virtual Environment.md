# What it is?

Virtual Environment (aka venv) is a way to install python packages only for a specific Python-Project, not globally for the whole system.




# How to install package into Virtual Environment

```shell
cd    "/path/to/your/project/folder"            # Go to your Project folder
python    -m  venv    ".virtual_environment_1"  # Create a Virtual Environment
source    ".virtual_environment_1/bin/activate" # Activate Virtual Environment
cd    "/path/to/downloaded/package"             # Go to downloaded package
python    -m  pip    install    "./"            # Manually install package
which    python                                 # Make shure that [package] is installed
```