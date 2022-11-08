#ifndef ADD_H
#define ADD_H

class Add
{
public:
    template <typename T>
    static T add(T a1, T a2)
    {
        return a1 + a2;
    }
};
#endif
