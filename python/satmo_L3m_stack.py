from pprint import pprint
import rasterio
from glob import glob
import os
import re
import datetime

data_root = '/export/isilon/datos2/satmo2_data'
output_dir = '/export/isilon/datos2/satmo_analysis'
var = 'sst'
suite = 'SST'
composite = '8DAY'
output_filename = os.dir.path(output_dir, 'stack.L3m_%s_%s_%s_2km.tif' % (composite, suite, var))
output_time_filename = os.dir.path(output_dir, 'stack.L3m_%s_%s_%s_2km.time' % (composite, suite, var))

file_list = sorted(glob(os.path.join(data_root, 'combined', 'L3m', composite, '*', '*', 'X*.L3m_%s_%s_%s_2km.tif' % (composite, suite, var))))

def get_date(x):
    pattern = re.compile(r'X(?P<time>\d{7})\.L3m.*\.tif$')
    m = pattern.match(os.path.basename(x))
    time = m.group('time')
    dt = datetime.datetime.strptime(time, "%Y%j").strftime("%Y-%m-%d")
    return dt

date_list = [get_date(x) for x in file_list]

with rasterio.open(file_list[0]) as src:
    meta = src.meta

meta.update(count = len(file_list), interleave='band')

# Write raster stack
with rasterio.open(output_filename, 'w', **meta) as dst:
    for id, file in enumerate(file_list):
        with rasterio.open(file) as src:
            dst.write_band(id + 1, src.read(1))

# Write time file
with open(output_time_filename, 'wb') as dst:
    for date in date_list:
        dst.write("%s\n" % date)