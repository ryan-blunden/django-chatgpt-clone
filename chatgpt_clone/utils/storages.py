from storages.backends.s3boto3 import S3Boto3Storage


# pylint: disable=abstract-method,too-few-public-methods
class StaticRootS3Boto3Storage(S3Boto3Storage):
    location = "static"
    default_acl = "public-read"


# pylint: disable=abstract-method,too-few-public-methods
class MediaRootS3Boto3Storage(S3Boto3Storage):
    location = "media"
    file_overwrite = False
