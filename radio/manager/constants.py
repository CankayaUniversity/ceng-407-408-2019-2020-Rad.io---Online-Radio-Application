import os
import radio.settings
import logging.config

logging.config.dictConfig(radio.settings.LOGGING)
logger = logging.getLogger(__name__)
