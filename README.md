# so-software-environment

scripts and documentation on bootstrapping a SO software environment in SO:UK.

# Creating SO software stack using conda

This is the recommended method if you are developing on your machine. For `simons1`, `soukdev1`, Blackett, SDSC, or NERSC, see relevant sections in SO wiki or talk to respective people in loading maintained SO software environments.

1. install conda/mamba first

2. install SO environment:

    - create new environment:

        - using conda:

            ```sh
            # you may need to activate the base environment first if you haven't done so.
            conda activate
            # or
            . activate
            # then
            conda env create -f examples/so.yml
            conda activate so-310
            python -m ipykernel install --user --name so-310 --display-name so-310
            ```

        - using mamba:

            ```sh
            # you may need to activate the base environment first if you haven't done so.
            conda activate
            # or
            . activate
            # then
            mamba env create -f examples/so.yml
            conda activate so-310
            python -m ipykernel install --user --name so-310 --display-name so-310
            ```

    - update existing environment:

        - using conda: `conda env update --name so-310 --file examples/so.yml --prune`

        - using mamba: `mamba env update --name so-310 --file examples/so.yml --prune`

3. install sotodlib:

    - install only:

        ```sh
        # branch such as master
        pip install git+https://github.com/simonsobs/sotodlib.git@master
        # version
        pip install git+https://github.com/simonsobs/sotodlib.git@v0.4.0
        ```

    - install and development:

        ```sh
        # go to some directory that you want to put the git repo first
        git clone git@github.com:simonsobs/sotodlib.git
        # change branch or tag if you need
        # pip install -e .
        ```

4. running TOAST test:

    ```sh
    python -c 'import toast.tests; toast.tests.run()'
    ```
