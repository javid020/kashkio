package com.k2o.aquahackathon.mapper;

import com.k2o.aquahackathon.dto.UserDto;
import com.k2o.aquahackathon.entity.User;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface UserMapper {

    UserMapper INSTANCE = Mappers.getMapper( UserMapper.class );

    UserDto userToUserDto(User user);

    Iterable<UserDto> userListToDto(Iterable<User> list);
}