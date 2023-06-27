"""Baseline openstudio functions."""
import openstudio as ops
from argparse import ArgumentParser
import os


def load_osm(osm_fpath):
    """Deserialize OSM from .osm file."""
    model = ops.model.Model.load(ops.toPath(osm_fpath))
    assert model.is_initialized()
    return model.get()

def dump_osm(osm_model, osm_fpath):
    """Serialize OSM as .osm file."""
    osm_model.save(ops.toPath(osm_fpath), True)
    return osm_fpath


def seed_osm():
    """Make, and return empty seed OSM."""
    return ops.model.Model()


if __name__ == '__main__':


    # Set args
    parser = ArgumentParser(
        prog='ops', description='cli for ops dev-ops')
    help_seed = ('Make empty seed OSM at given fpath.\n'
                 'Ex: $python ops.py -seed $PWD/seed.osm')
    parser.add_argument('-seed', type=str,help=help_seed)
    #parser.add_argument('-verbose', action='store_false')

    # Parse args
    args = parser.parse_args()
    if args.seed:
        print(dump_osm(seed_osm(), args.seed))



