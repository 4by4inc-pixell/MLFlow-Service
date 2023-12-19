import argparse
import sys
import os

def parse_args() -> argparse.Namespace:
    paser = argparse.ArgumentParser(description="get enviroment variable and write it to the file.")
    paser.add_argument("ENV_VAR_NAME", type=str)
    paser.add_argument("RESULT_FILE_PATH", type=str)
    return paser.parse_args()

def main(args:argparse.Namespace) -> bool:
    # get args
    env_var_name = args.ENV_VAR_NAME
    result_file_path = args.RESULT_FILE_PATH

    # generate the file
    try:
        assert env_var_name in os.environ.keys(), "The env_var_name is not exist."
        content = os.environ[env_var_name]
        assert content != "", "The content is empty."
        assert not os.path.exists(result_file_path), "The file(at result_file_path) is already exist."
        with open(result_file_path, 'w') as f:
            f.write(content)
        assert os.path.exists(result_file_path), "The file(at result_file_path) is not exist."
    except Exception as ex:
        print(ex)
        return False
    return True

if __name__ == "__main__":
    args = parse_args()
    ret = main(args=args)
    sys.exit(0 if ret is True else -1)