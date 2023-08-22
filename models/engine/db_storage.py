#!/usr/bin/python3

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from models.amenity import Amenity
from models.base_model import Base, BaseModel
from models.state import State
from models.user import User
from models.place import Place
from models.review import Review
from models.city import City

classes = {"Amenity":Amenity, "BaseModel":BaseModel, "City": City,
	"Place":Plcae, "Review": Review, "State": State, "User":User}

class DBStorage:
	'''Database'''
	   __engine = None
	   __session = None


	   def __init__(self):
		   self.__engine = create_engine('mysql+mysqldb://{}:{}@{}/{}'.format(HBNB_MYSQL_USER,
	       HBNB_MYSQL_PWD,
	       HBNB_MYSQL_HOST,
	       HBNB_MYSQL_DB),pool_pre_ping=True)

	    if HBNB_ENV == 'test':
	       Base.metadata.drop_all(self.__engine)

	def save(self):
		""" Saving our sessions """
			self.__session.commit()
	
	def delete(self,obj=None):
		""" Deleting from current database session """
	    if obj is None:
	        self.__session.query(type(obj)).filter(type(obj).id == obj.id).delete()

       def new(self, obj):

	       self.__session.add(obj)
