/**
 * Created by Max Rozdobudko on 9/8/15.
 */
package org.spicefactory.parsley.command
{
import org.spicefactory.parsley.command.tag.AbstractCommandGroupTag;
import org.spicefactory.parsley.command.tag.CommandTag;
import org.spicefactory.parsley.command.tag.MapCommandTag;

public class MapCommandBuilder
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function MapCommandBuilder(groupType:Class = null)
    {
        super();

        _groupType = groupType;
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    private var _groupType:Class;

    private var _messageType:Class;

    private var _commands:Array = [];

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    public function messageType(type:Class):MapCommandBuilder
    {
        _messageType = type;

        return this;
    }

    public function command(type:Class):MapCommandBuilder
    {
        _commands.push(type);

        return this;
    }

    public function build():MapCommandTag
    {
        var mapper:MapCommandTag = new MapCommandTag();
        mapper.messageType = _messageType;

        if (_groupType != null)
        {
            mapper.command = new AbstractCommandGroupTag(_groupType);

            for (var i:int = 0, n:int = _commands != null ? _commands.length : 0; i < n; i++)
            {
                var command:CommandTag = new CommandTag();
                command.type = _commands[i];

                AbstractCommandGroupTag(mapper.command).commands[i] = command;
            }
        }
        else
        {
            mapper.type = _commands[0];
        }

        return mapper;
    }
}
}
